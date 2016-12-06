"
I run timings of blocks on a Javascript engine.

My primary use is to explore how useful a given optimization is, as I record the ratio of unoptimized versus optimized Javascript code.

"
Class {
	#name : #PjTimingTest,
	#superclass : #Object,
	#instVars : [
		'exporter',
		'bridge',
		'nullBlock',
		'selector'
	],
	#classInstVars : [
		'stats'
	],
	#category : #'PharoJsTiming-Timing'
}

{ #category : #stats }
PjTimingTest class >> gatherStatistics [
	<script>
	self runTests.
	self stats inspect.

]

{ #category : #'initialize-release' }
PjTimingTest class >> initialize [
	self reset
]

{ #category : #testing }
PjTimingTest class >> ratio: aString  betterThan: factor for:  aTest [
	| averages ratio unopt opt base |
	averages :=  (((((aString allButFirst: 2)
		allButLast: 2)
			splitOn: '],[') collect: [ : each |
				($, split: each) collect: #asUnsignedInteger ])
					collect: #average)
						collect: #asFloat.
	base := averages first.
	opt := averages third.
	base * 2 > opt ifTrue: [ base:=0 ].
	opt := opt - base.
	unopt := averages second - base.
	opt > 0 ifFalse: [ ^ aTest fail: 'optimized version inadequate time - rerun test' ].
	ratio := unopt / opt.
	(stats at: aTest selector ifAbsentPut: [ OrderedCollection new ]) add: ratio.
	^ ratio >= factor
]

{ #category : #'initialize-release' }
PjTimingTest class >> reset [
	stats := Dictionary new.

]

{ #category : #stats }
PjTimingTest class >> runTests [
	| instance |
	self testSelectors do: [: testName |
		instance := self new.
		instance selector: testName.
		[
			instance setUp.
			instance perform: testName asSymbol.
		] ensure: [[
				instance tearDown
			] on: Error do: [  ]
		]
	]
]

{ #category : #stats }
PjTimingTest class >> stats [
	" self stats  "
	^ String streamContents: [ : aStream |
		aStream nextPutAll: 'Ratio of unopt/optimized runs';cr.
		stats keys sorted do: [ : key |
			aStream nextPutAll: (key padRightTo: 30).
			(stats at: key) do: [ : each |
				aStream nextPutAll: (each printShowingDecimalPlaces: 2);nextPut: $ 
			].
			aStream cr
		]
	]	
]

{ #category : #stats }
PjTimingTest class >> testSelectors [
	^(self selectors select: [ :each | (each beginsWith: 'test') and: [each numArgs isZero]])
]

{ #category : #'testing support' }
PjTimingTest >> assert: aBlock isFasterThan: bBlock with: someOptimizations [
	| noOptim optim results |
	exporter ifNil: [self assert: false description: 'no bridge available'].
	self transpiler delayDNU: true.
	self transpiler removeAllConversions: someOptimizations.
	noOptim := self transpiler convertToJs: bBlock.
	self transpiler addAllConversions: someOptimizations.
	optim := self transpiler convertToJs: aBlock.
	self transpiler delayDNU: false.
	results := bridge evalMessage: (PjJavascriptMessage receiverId: #PjTimingPlatformApp selector: #timeNull:nonOptimized:optimized: arguments:  {
		PjUnparsedStringNode string: nullBlock.
		PjUnparsedStringNode string: noOptim.
		PjUnparsedStringNode string: optim }) .
"	results := bridge evalJavascript: 'global.PjTimingPlatformApp._timeNull_nonOptimized_optimized_(', nullBlock,',', noOptim,',', optim,')'.
"	self assert: (self class ratio: results betterThan:  1.2 for: self)
]

{ #category : #'testing support' }
PjTimingTest >> assert: aBlock isFasterWith: someOptimizations [
	self assert: aBlock isFasterThan: aBlock with: someOptimizations
]

{ #category : #accessing }
PjTimingTest >> selector [
	^ selector
]

{ #category : #accessing }
PjTimingTest >> selector: anObject [
	selector := anObject
]

{ #category : #running }
PjTimingTest >> setUp [
	bridge := PjTimingPlatformApp bridgeForDebug.
	bridge timeout: 60 seconds.
	exporter := bridge exporter.
	exporter transpiler: PjTimingTestTranspiler new.
	self transpiler addAllOptionalConversions.
	self transpiler removeAllConversions: { PjIfFalseOptimization }.
	self transpiler addAllConversions: { PjIfTrueOptimization }.
	nullBlock := self transpiler convertToJs: [  ].
	bridge start.

]

{ #category : #running }
PjTimingTest >> tearDown [
	bridge stop.

]

{ #category : #testing }
PjTimingTest >> testArithmeticOperators [
	self assert: [ 1-2 ] isFasterWith: PjArithmeticOptimization allSubclasses
]

{ #category : #testing }
PjTimingTest >> testComparisonOperators [
	self assert: [ 1<2 ] isFasterWith: PjComparisonOptimization allSubclasses
]

{ #category : #testing }
PjTimingTest >> testIfThen [
	self with: [ | w | w := 1 ] do: [
		self
			assert: [ | w | w := 1. w<2 ifTrue: [ w := 0]]
			isFasterWith: PjIfTrueIfFalseOptimization withAllSubclasses,
							PjComparisonOptimization allSubclasses
	]
]

{ #category : #testing }
PjTimingTest >> testNonlocalReturns [
	bridge timeout: 150 seconds.
	self
		assert: [ PjTimingPlatformApp ifTrueExample: 15 ]
		isFasterThan: [ PjTimingPlatformApp ifFalseExample: 15 ]
		with: #()
]

{ #category : #testing }
PjTimingTest >> testTimesRepeat [
	self with: [ | w | w := 0 . nil] do: [
		self
			assert: [ | w | 10 timesRepeat: [ w := 0]]
			isFasterWith: PjTimesRepeatOptimization withAllSubclasses
	]
]

{ #category : #testing }
PjTimingTest >> testToDo [
	self with: [ | w | w := 10. w := 0 . nil] do: [
		self
			assert: [ | w | w := 10. 1 to: w do: [ :x| w := x]]
			isFasterWith: PjToDoOptimization withAllSubclasses
	]
]

{ #category : #testing }
PjTimingTest >> testWhile [
	self with: [ | w x | x := 10. x := x - 1. w := 0. nil ] do: [
		self
			assert: [ | w x | x := 10. [x>0] whileTrue: [ x := x - 1. w := 0]]
			isFasterWith: PjWhileOptimization allSubclasses
	]
]

{ #category : #accessing }
PjTimingTest >> transpiler [
	^ exporter transpiler
]

{ #category : #'testing support' }
PjTimingTest >> with: nBlock do: tBlock [
	| saveBlock |
	saveBlock := nullBlock.
	[
		nullBlock := self transpiler convertToJs: nBlock.
		tBlock value
	] ensure: [ nullBlock := saveBlock ]
]
