Class {
	#name : 'PjArrayTest',
	#superclass : 'PjBridgeTestCase',
	#category : 'PharoJs-Base-JS-CoreLibraries-Tests-Collections',
	#package : 'PharoJs-Base-JS-CoreLibraries-Tests',
	#tag : 'Collections'
}

{ #category : 'tests' }
PjArrayTest >> testAllButFirst [
	| array |
	array := self bridge evalBlock: [ #(10 20 30 40) ].
	self assert: array allButFirst size equals: array size - 1
]

{ #category : 'tests' }
PjArrayTest >> testArrayClassDoesNotOverlapWithArrayFunction [
	self assertJavascript: 'typeof Array' evaluatesTo: 'function'.
	self assertJavascript: 'typeof PjArray' evaluatesTo: 'undefined'.
]

{ #category : 'tests' }
PjArrayTest >> testArrayWith1Element [
	self assert: [{1}] evaluatesToRaw: '[1]'.
	self assert: [#(1)] evaluatesToRaw: '[1]'.
]

{ #category : 'tests' }
PjArrayTest >> testArrayWith2Elements [
	self assert: [{1. 2}] evaluatesToRaw: '[1,2]'.
	self assert: [#(1 2)] evaluatesToRaw: '[1,2]'.
]

{ #category : 'tests' }
PjArrayTest >> testArrayWithMoreElements [
	self assert: [{1. 2}] evaluatesToRaw: '[1,2]'.
	self assert: [#(1 2)] evaluatesToRaw: '[1,2]'.
	self assert: [#(1 true 'id' 'x\y"z')] evaluatesToRaw: '[1,true,"id","x\\y\"z"]'.
]

{ #category : 'tests' }
PjArrayTest >> testAsOrderedCollection [
	| orderedCollection |
	orderedCollection := self evalBlock: [#(1 2 3 4) asOrderedCollection].
	self assert: orderedCollection size equals: 4.
]

{ #category : 'tests' }
PjArrayTest >> testAt [
	| array |
	array := self bridge evalBlock: [ #(10 20 30 40) ].
	#(10 20 30 40)
		doWithIndex:
			[ :expectedValue :index | self assert: [ array at: index ] evaluatesTo: expectedValue ]
]

{ #category : 'tests' }
PjArrayTest >> testAtIfAbsent [
	| array actualValue |
	array := self bridge evalBlock: [ #(10 20 30) ].
	#(10 20 30)
		withIndexDo: [ :expectedValue :index | 
			actualValue := self bridge
				evalBlock: [ array at: index ifAbsent: [ nil ] ].
			self assert: actualValue equals: expectedValue ].
	actualValue := self bridge
		evalBlock: [ array at: 10 ifAbsent: [ 100 ] ].
	self assert: actualValue equals: 100
]

{ #category : 'tests' }
PjArrayTest >> testAtPut [
	| array |
	array := self bridge evalBlock: [ #(10 20 30 40) ].
	#(11 22 33 44)
		doWithIndex:
			[ :newValue :index | self bridge evalBlock: [ array at: index put: newValue ] ].
	self assert: [ array ] evaluatesToRaw: '[11,22,33,44]'
]

{ #category : 'tests' }
PjArrayTest >> testAverage [
	self assertEquivalent: [#(2 3 4 5) average].
	self assertEquivalent: [#(3 2 6 10) average].
]

{ #category : 'tests' }
PjArrayTest >> testCircularReference [
	| array |
	array := self bridge evalBlock: [#('X')].
	self deny: (array includes: array).
]

{ #category : 'tests' }
PjArrayTest >> testCollect [
	| double |
	double := self bridge
		evalBlock: [ | array |
			array := #(10 20 30 40).
			array collect: [ :element | 2 * element ] ].
	#(20 40 60 80)
		doWithIndex:
			[ :expectedValue :index | self assert: [ (double at: index) = expectedValue ] evaluatesTo: true ]
]

{ #category : 'tests' }
PjArrayTest >> testCollectPerform [
	| double |
	double := self bridge
		evalBlock: [ | array |
			array := #(10 -20 -30 40).
			array collect: [ :each | each abs ] ].
	#(10 20 30 40)
		doWithIndex:
			[ :expectedValue :index | self assert: [ (double at: index) = expectedValue ] evaluatesTo: true ]
]

{ #category : 'tests' }
PjArrayTest >> testCollectPerformSymbol [
	| double |
	double := self bridge
		evalBlock: [ | array |
			array := #(10 -20 -30 40).
			array collect: #abs ].
	#(10 20 30 40)
		doWithIndex:
			[ :expectedValue :index | self assert: [ (double at: index) = expectedValue ] evaluatesTo: true ]
]

{ #category : 'tests' }
PjArrayTest >> testConverstionToArray [
	| collection |
	collection := self evalBlock: [#(1 2 3 4)].
	self deny: collection asArray identicalTo: collection.
]

{ #category : 'tests' }
PjArrayTest >> testConverstionToSet [
	| setFromArray |
	setFromArray := self bridge evalBlock: [ #(10 20 30 40) asSet ].
	setFromArray addAll: #(10 20 30 40).
	self assert: setFromArray size equals: 4.
	setFromArray add: 30.
	self assert: setFromArray size equals: 4.
	setFromArray add: 50.
	self assert: setFromArray size equals: 5.
	#(10 20 30 40 50) do: [ :each |
		self assert: (setFromArray includes: each) ]
]

{ #category : 'tests' }
PjArrayTest >> testCopy [
	| tests |
	tests := self bridge
		evalBlock: [ | array |
			array := #(10 20 30 40).
			{array copy = array. array copy == array} ].
	self assert: tests first.
	self deny: tests last.
]

{ #category : 'tests' }
PjArrayTest >> testCopyWith [

	self assertEquivalent: [ #(  ) copyWith: 4 ].
	self assertEquivalent: [ #( 2 3 4 5 ) copyWith: 6 ].
	
]

{ #category : 'tests' }
PjArrayTest >> testCreationWithAll [

	| jsArray |
	jsArray := self bridge evalBlock: [ Array withAll: #( 42 37 255 ) ].
	self assert: jsArray size equals: 3.
	self assertCollection: jsArray asLocalObject equals: #( 42 37 255 )
]

{ #category : 'tests' }
PjArrayTest >> testDetectIfFound [
	self
		assertEquivalent: [|array found|
			array := #(1 2 3 4).
			found := false.
			array detect: [ : element | console log: element. element == 2] ifFound: [found := true].
			found].
]

{ #category : 'tests' }
PjArrayTest >> testDetectIfNone [
	self 
		assertEquivalent: [|array notFound| array := #(1 2 3 4).
			notFound := false.
			array detect: [ : element | element == 5] ifNone: [notFound := true].
			notFound].
]

{ #category : 'tests' }
PjArrayTest >> testDo [
	self
		assertEquivalent: [|array total|
			array := #(1 2 3 4).
			total := 0.
			array do: [ : element | total := total + element].
			total].
]

{ #category : 'tests' }
PjArrayTest >> testDoWithIndex [
	self
		assertEquivalent: [|array total|
			array := #(10 20 30 40).
			total := 0.
			array doWithIndex: [ : element : index | total := total + index].
			total].
]

{ #category : 'tests' }
PjArrayTest >> testEmptyArray [
	self assert: [{}] evaluatesToRaw: '[]'.
	self assert: [#()] evaluatesToRaw: '[]'.
]

{ #category : 'tests' }
PjArrayTest >> testEquality [
	self assertEquivalent: [#() = #()].
	self assertEquivalent: [#(11) = #(11)].
	self assertEquivalent: [#(11 22) = #(11 22)].
	self assertEquivalent: [#(11 22 33) = #(11 22 33)].
	self assertEquivalent: [#(11 33 22) = #(11 22 33)].
]

{ #category : 'tests' }
PjArrayTest >> testIncludes [
	self assertEquivalent: [#() includes: 4].
	self assertEquivalent: [#(2 3 4 5) includes: 4].
	self assertEquivalent: [#() includes: 'hello'].
	self assertEquivalent: [#(2 'hello' 5) includes: 'hello'].
	self assertEquivalent: [ #(2 3 (4 5) 6) includes: #(4 5) ].
	self assertEquivalent: [ #(2 3 (4 5) 6) includes: #(5 6) ].
]

{ #category : 'tests' }
PjArrayTest >> testIncludesAll [
	self assertEquivalent: [#() includesAll: #(4)].
	self assertEquivalent: [#(2 3 4 5) includesAll: #(4)].
	self assertEquivalent: [#() includesAll: #('hello')].
	self assertEquivalent: [#(2 'hello' 5) includesAll: #('hello')].
	self assertEquivalent: [ #(2 3 4 5 6) includesAll: #(4 5) ].
	self assertEquivalent: [ #(2 3 4 5 6) includesAll: #(6 2 6) ].
]

{ #category : 'tests' }
PjArrayTest >> testIncludesAny [
	self assertEquivalent: [#() includesAny: #(4)].
	self assertEquivalent: [#(2 3 4 5) includesAny: #(4)].
	self assertEquivalent: [#() includesAny: #('hello')].
	self assertEquivalent: [#(2 'hello' 5) includesAny: #('hello')].
	self assertEquivalent: [ #(2 3 4 5 6) includesAny: #(4 5) ].
	self assertEquivalent: [ #(2 3 4 5 6) includesAny: #(6 2 6) ].
]

{ #category : 'tests' }
PjArrayTest >> testInserElement [
]

{ #category : 'tests' }
PjArrayTest >> testIsEmpty [
	self assertEquivalent: [#() isEmpty].
	self assertEquivalent: [#(11) isEmpty].
	self assertEquivalent: [#(11 22 33) isEmpty].
]

{ #category : 'tests' }
PjArrayTest >> testNotEmpty [
	self assertEquivalent: [#() notEmpty].
	self assertEquivalent: [#(11) notEmpty].
	self assertEquivalent: [#(11 22 33) notEmpty].
]

{ #category : 'tests' }
PjArrayTest >> testReject [
	| filtered |
	filtered := self bridge evalBlock: [ #(10 20 30 40) reject: [ : each | each > 35 or: [ each < 15 ] ]].
	self assert: filtered size equals: 2.
	self assert: filtered first equals: 20.
	self assert: filtered last equals: 30.
]

{ #category : 'tests' }
PjArrayTest >> testRemove [
	self assertEquivalent: [ #(10 20 30 40) asOrderedCollection removeAt: 2 ].
	self assertEquivalent: [ (#(10 20 30 40) asOrderedCollection removeAt: 2;yourself) asArray ].
]

{ #category : 'tests' }
PjArrayTest >> testReversed [
	self
		assertEquivalent: [|array|
			array := #(1 2 3 4).
			array,array reversed].
]

{ #category : 'tests' }
PjArrayTest >> testShallowCopy [
	| clone |
	clone := self evalBlock: [ #(11 22 33) copy].
	self assert: clone size equals: 3.
	#(11 22 33) withIndexDo: [ : each : index |
		self assert: (clone at: index) equals: each
		 ].
]

{ #category : 'tests' }
PjArrayTest >> testSize [
	self assertEquivalent: [#() size].
	self assertEquivalent: [#(11 ) size].
	self assertEquivalent: [#(11 22) size].
	self assertEquivalent: [#(11 22 33) size].
]

{ #category : 'tests' }
PjArrayTest >> testSorted [

	| unsorted sortedAscending sortBlock sortedDescending |
	unsorted := self bridge evalBlock: [ #( 30 10 40 20 ) ].
	sortedAscending := unsorted sorted.
	self assert: sortedAscending className equals: unsorted className.
	self
		assertCollection: sortedAscending asLocalObject
		equals: #( 10 20 30 40 ).
	sortBlock := self bridge evalBlock: [ [ :a :b | a >= b ] ].
	sortedDescending := unsorted sorted: sortBlock.
	self assert: sortedDescending className equals: unsorted className.
	self
		assertCollection: sortedDescending asLocalObject
		equals: #( 40 30 20 10 )
]

{ #category : 'tests' }
PjArrayTest >> testSortedCollection [

	| unsorted sortedCollectionAscend sortedCollectionDescend sortBlock |
	unsorted := self bridge evalBlock: [ #( 30 10 40 20 ) ].

	sortedCollectionAscend := unsorted asSortedCollection.
	self
		assertCollection: sortedCollectionAscend asLocalObject
		equals: #( 10 20 30 40 ).
	sortBlock := self bridge evalBlock: [ [ :a :b | a >= b ] ].
	sortedCollectionDescend := unsorted asSortedCollection: sortBlock.
	self
		assertCollection: sortedCollectionDescend asLocalObject
		equals: #( 40 30 20 10 )
]
