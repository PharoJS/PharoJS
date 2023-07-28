Class {
	#name : #PjJsConfigTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #tests }
PjJsConfigTest >> testFlatObject [

	| config |
	config := self evalBlock: [
		          PjConfig jsObject: [ :o |
			          o
				          int: 42;
				          string: 'pharo';
				          array: #( 1 2 3 );
				          block: [ :x | x * x ]] ].
	self assert: config int equals: 42.
	self assert: config string equals: 'pharo'.
	self assert: ((config at: #block) value: 9) equals: 81.
	self assert: config array size equals: 3.
	self assert: config array second equals: 2
]

{ #category : #tests }
PjJsConfigTest >> testFrozenObject [

	| config |
	config := self evalBlock: [ PjConfig new ].
	config a: 1.
	config b: 2.
	config := config becomeJsObject.
	self assert: config a equals: 1.
	self assert: config b equals: 2.
	config a: 99.
	self assert: config a equals: 99.
	self should: [ config c: 3 ] raise: Error.

]

{ #category : #tests }
PjJsConfigTest >> testMultiLevelsObject [

	| config bar |
	config := self evalBlock: [
		          PjConfig jsObject: [ :o |
			          o foo bar << [: b |
							b x
				          int: 42;
				          string: 'pharo'.
				b y
				          array: #( 1 2 3 );
				          block: [ :x | x * x ] ] ]].
	bar := config foo bar.
	self assert: bar x int equals: 42.
	self assert: bar x string equals: 'pharo'.
	self assert: ((bar y at: #block) value: 9) equals: 81.
	self assert: bar y array size equals: 3.
	self assert: bar y array second equals: 2
]
