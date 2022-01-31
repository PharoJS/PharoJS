Class {
	#name : #PjClassSortingTest,
	#superclass : #TestCase,
	#instVars : [
		'cache',
		'transpiler'
	],
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #testing }
PjClassSortingTest >> assert: aClass isBefore: bClass [
	self assert: (self should: aClass initializeBefore: bClass).
	self deny: (self should: bClass initializeBefore: aClass)
]

{ #category : #testing }
PjClassSortingTest >> assert: aClass isUnrelatedTo: bClass [
	self deny: (self should: aClass initializeBefore: bClass).
	self deny: (self should: bClass initializeBefore: aClass)
]

{ #category : #testing }
PjClassSortingTest >> checkInheritanceOrdered: sorted [
	sorted
		withIndexDo: [ :first :index | 
			index + 1 to: sorted size do: [ :secondIndex | 
				| second |
				second := sorted at: secondIndex.
				self
					assert: ((second inheritsFrom: first) or: [ (first inheritsFrom: second) not ]) ] ]
]

{ #category : #testing }
PjClassSortingTest >> checkInitializationOrdered: sorted [
	sorted
		withIndexDo: [ :first :index | 
			index + 1 to: sorted size do: [ :secondIndex | 
				| second |
				second := sorted at: secondIndex.
				self
					assert: ((self does: second reference: first) or: [ (self does: first reference: second) not ]) ] ]
]

{ #category : #testing }
PjClassSortingTest >> does: classB reference: classA [

	| classesReferencingA |
	classesReferencingA := cache at: classA ifAbsentPut: [ 
		                       | methodsReferencingA |
		                       methodsReferencingA := SystemNavigation 
			                                              globalRefsForPharoJS:
			                                              classA
				                                              nameToUseForJsConversion.
		                       methodsReferencingA asSet collect: [ :each | 
			                       each methodClass instanceSide ] ].
	^ (classesReferencingA includes: classB) or: [ 
		  classB sharedPools includes: classA ]
]

{ #category : #running }
PjClassSortingTest >> setUp [
	super setUp.
	cache := IdentityDictionary new.
	transpiler := PjTranspiler new.
]

{ #category : #testing }
PjClassSortingTest >> should: bClass initializeBefore: aClass [
	^ transpiler should: bClass occurBefore: aClass with: [ : first : last |
		transpiler does: last reference: first ]
]

{ #category : #testing }
PjClassSortingTest >> testClassInheritenceBasedOrdering [
	| sorted classes |
	classes := Object withAllSuperclasses asIdentitySet
		, (Object subclasses first: 10) , IdentitySet withAllSuperclasses
		, String withAllSuperclasses , SmallInteger withAllSuperclasses.
	" all the above have no inheritance (once we remove Object superclasses at the end) "
	Object withAllSuperclasses do: [ :each | classes remove: each ].
	" now we have a bunch of heirarchies that are mutually incomparable "
	sorted := Class superclassOrder: classes.
	self checkInheritanceOrdered: sorted.
]

{ #category : #testing }
PjClassSortingTest >> testClassIntializationOrdering [
	| sorted classes |
	classes := {
		PjClassForTranspilationTest.
		PjSuperClassForTranspilationTest.
		PjSharedPoolForTest.
		PjClientForInitializationTest.
		PjClassDForPackageTranspilationTest.  
		PjClassEForPackageTranspilationTest. 
		PjClientForJavascriptInitializationTest.
		PjClassCForPackageTranspilationTest.
		PjProviderForInitializationTest.
		PjClassBForPackageTranspilationTest.
	}.
	sorted := transpiler orderForInitialization: classes.
	self checkInitializationOrdered: sorted.
	self checkInheritanceOrdered: sorted.
]

{ #category : #testing }
PjClassSortingTest >> testShouldInitializeBefore [
	| relationships classes |
	relationships := {
		PjSharedPoolForTest -> PjSuperClassForTranspilationTest.
		PjSuperClassForTranspilationTest -> PjClassForTranspilationTest.
		PjProviderForInitializationTest -> PjClientForInitializationTest.
		PjProviderForInitializationTest -> PjClientForJavascriptInitializationTest.
		PjClassBForPackageTranspilationTest -> PjClassCForPackageTranspilationTest.
		PjClassBForPackageTranspilationTest -> PjClassDForPackageTranspilationTest.
		PjClassBForPackageTranspilationTest -> PjClassEForPackageTranspilationTest.
		PjClassDForPackageTranspilationTest -> PjClassEForPackageTranspilationTest.
		PjClientForJavascriptInitializationTest -> PjClassForTranspilationTest.
	} asSet.
	classes := IdentitySet new.
	relationships do: [ : assoc |
		self assert: assoc key isBefore: assoc value.
		classes add: assoc key;add: assoc value
	].
	classes do: [ : first |
		classes do: [ :second |
			(first = second or: [(relationships includes: first->second) or: [relationships includes: second->first]]) ifFalse: [
				self assert: first isUnrelatedTo: second
	]]]
]
