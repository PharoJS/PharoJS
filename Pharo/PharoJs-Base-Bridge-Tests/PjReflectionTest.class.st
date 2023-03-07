Class {
	#name : #PjReflectionTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #tests }
PjReflectionTest >> testClassName [

	| class |
	class := classFactory
		silentlyNewSubclassOf: PjObject
		instanceVariableNames: 'x y'
		classVariableNames: ''.
	self bridge loadClass: class.
	self assert: [ class name ] evaluatesTo: class name asString.
	self assert: [ class new className ] evaluatesTo: class name asString
]

{ #category : #tests }
PjReflectionTest >> testDirectSubclasses [

	| objectInitialSubclassesSize objectNewSubclassesSize |
	objectInitialSubclassesSize := self evalBlock: [ Object subclasses size  ].	
	self assertBlock: [Object subclasses includesAll: { PjFunction. PjArray. PjNumber. PjBoolean } ].	
	self assert: objectInitialSubclassesSize > 4.
	self bridge loadClass: PjArrayClassExtensionForTest.
	self assertBlock: [ Object subclasses size = objectInitialSubclassesSize].	
	self assertBlock: [PjFunction subclasses size = 1 ].
	self assertBlock: [PjFunction subclasses includes: PjClass ].
	self bridge loadAllClasses: { PjBSubClassOfA . PjCSubClassOfA  }.
	objectNewSubclassesSize := self evalBlock: [ Object subclasses size  ].	
	self assert: objectNewSubclassesSize equals: objectInitialSubclassesSize + 1.
	self assertBlock: [PjASuperClass subclasses size = 2 ].
	self assertBlock: [PjASuperClass subclasses includes: PjBSubClassOfA].
	self assertBlock: [PjASuperClass subclasses includes: PjCSubClassOfA].
	self assertBlock: [PjBSubClassOfA subclasses isEmpty ].
	self assertBlock: [PjCSubClassOfA subclasses isEmpty ].
	

]

{ #category : #tests }
PjReflectionTest >> testDirectSuperclass [
	
	self assertBlock: [PjClass superclass == PjFunction ].
	self assertBlock: [PjFunction superclass == Object ].
	self assertBlock: [Object superclass isNil ].
	self assertBlock: [PjArray superclass == Object ].
	self bridge loadAllClasses: { PjBSubClassOfA . PjCSubClassOfA  }.
	self assertBlock: [PjASuperClass superclass == Object ].
	self assertBlock: [PjBSubClassOfA superclass == PjASuperClass ].
	self assertBlock: [PjCSubClassOfA superclass == PjASuperClass ].
	

]

{ #category : #tests }
PjReflectionTest >> testMetaclassLink [
	
	self assertBlock: [( Object getPrototypeOf: PjClass prototype) == PjFunction prototype ].
	self assertBlock: [( Object getPrototypeOf: PjClass) == PjFunction ].
	self assertBlock: [( Object getPrototypeOf: PjFunction) == Object ].
	self assertBlock: [( Object getPrototypeOf: PjArray) == Object ].
	self assertBlock: [( Object getPrototypeOf: PjBoolean ) == Object ].
	self assertBlock: [( Object getPrototypeOf: PjDate ) == Object ].
	self assertBlock: [( Object getPrototypeOf: PjNumber) == Object ].
	self assertBlock: [( Object getPrototypeOf: PjString) == Object ].

]

{ #category : #tests }
PjReflectionTest >> testNestedRepeats [

	| class tryNestedRepeatsSelector tryNestedRepeatsMethod |
	class := classFactory
		silentlyNewSubclassOf: PjObject
		instanceVariableNames: 'x y'
		classVariableNames: ''.
	tryNestedRepeatsSelector := #tryNestedRepeats.
	tryNestedRepeatsMethod := self class compiledMethodAt: tryNestedRepeatsSelector.
	class compile: tryNestedRepeatsMethod sourceCode.
	self bridge loadClass: class.
	self
		assert: [ class new tryNestedRepeats ]
		evaluatesTo: self tryNestedRepeats
]

{ #category : #tests }
PjReflectionTest >> testReflection [

	self assertEquivalent: [ Number inheritsFrom: Object ].
	self assertEquivalent: [ Number canUnderstand: #isNil ].
	self assertEquivalent: [ Number canUnderstand: #someSelectorThatDoesntExist ].
	self assertEquivalent: [ Number canUnderstand: #ifTrue: ].
	self assertEquivalent: [ 42 respondsTo: #ifTrue: ].
	self assertEquivalent: [ 42 respondsTo: #abs ].
	self assertEquivalent: [ true respondsTo: #ifTrue: ].
	self assertEquivalent: [ Object new respondsTo: #neverDefined ].
	self assert: [ document respondsTo: #neverDefined ] evaluatesTo: false.
	self assertEquivalent: [ 3 isKindOf: Number ].
	self assertEquivalent: [ 3 isKindOf: Object ].
	self assertEquivalent: [ 3 isMemberOf: SmallInteger ].
	self assertEquivalent: [ 3 isMemberOf: Object ].
	self assertEquivalent: [ true respondsTo: #not ].
	self assertEquivalent: [ true respondsTo: #ifTrue: ].
	self assertEquivalent: [ 42 respondsTo: #<= ].
]

{ #category : #tests }
PjReflectionTest >> testTemporaries [
	| class tryTemporariesSelector tryTemporariesMethod |
	class := classFactory
		silentlyNewSubclassOf: PjObject
		instanceVariableNames: 'x y'
		classVariableNames: ''.
	tryTemporariesSelector := #tryTemporaries.
	tryTemporariesMethod := self class compiledMethodAt: tryTemporariesSelector.
	class compile: tryTemporariesMethod sourceCode.
	self bridge loadClass: class.
	self
		assert: [ class new tryTemporaries ]
		evaluatesTo: self tryTemporaries
]

{ #category : #'test support' }
PjReflectionTest >> tryNestedRepeats [
		| x |
		x := 1.
		5 timesRepeat: [| w |
			w := w ifNil: [ x ].
			10 timesRepeat: [
				x := x + 1].
			x := x + w].
		^ x
]

{ #category : #'test support' }
PjReflectionTest >> tryTemporaries [ 
		| x b |
		b := [ : a | | y |
			11 timesRepeat: [ | w |
				w := (w ifNil: [ 0 ])+(a*100).
				y := (y ifNil: [ 0 ])+w.
			].
			b isNil ifFalse: [ | z |
				z := (z ifNil: [ 0 ])+a.
				y := (y ifNil: [ 0 ])+(a*10).
				x := (x ifNil: [ 0 ])+(a*100000)+y+z]].
		b value: 1.
		b value: 4.
		^ x
]
