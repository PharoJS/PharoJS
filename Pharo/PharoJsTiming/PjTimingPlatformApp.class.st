"
I am an App to determine timings of blocks.

This is used to justify optimizations
"
Class {
	#name : #PjTimingPlatformApp,
	#superclass : #PjWebApplication,
	#pools : [
		'PjUniversalGlobals'
	],
	#classInstVars : [
		'iterations',
		'minimumTrials'
	],
	#category : #'PharoJsTiming-Client'
}

{ #category : #exporting }
PjTimingPlatformApp class >> appJsFileName [
	<pharoJsSkip>
	^ 'timing.js'
]

{ #category : #timing }
PjTimingPlatformApp class >> excessiveVariance: results [
	^ false
]

{ #category : #timing }
PjTimingPlatformApp class >> findBaseIterations: aBlock and: aBlock2 min: mintime [
	| elapsed |
	elapsed := 0.
	[ (elapsed := (self timeBlock: aBlock) + (self timeBlock: aBlock2) / 2) < mintime ] whileTrue: [
		console log: iterations.
		iterations := iterations + iterations
	].
	[ (elapsed := (self timeBlock: aBlock) + (self timeBlock: aBlock2) / 2) /3  > mintime ] whileTrue: [
		console log: iterations.
		iterations := iterations * 2 // 3
	].

]

{ #category : #timing }
PjTimingPlatformApp class >> findStableTiming: aBlock [
	| results |
	results := #().
	[ results size < minimumTrials or: [ self excessiveVariance: results ]] whileTrue: [
		results add: (self timeBlock: aBlock)
	].
	^ results
]

{ #category : #'for testing' }
PjTimingPlatformApp class >> ifFalseExample: arg [
	arg < 10 ifFalse: [ ^ arg ]
]

{ #category : #'for testing' }
PjTimingPlatformApp class >> ifTrueExample: arg [
	arg >= 10 ifTrue: [ ^ arg ]
]

{ #category : #public }
PjTimingPlatformApp class >> playgroundDoNotList [
	< pharoJsSkip >
]

{ #category : #'start-stop application' }
PjTimingPlatformApp class >> start [

]

{ #category : #timing }
PjTimingPlatformApp class >> timeBlock: aBlock [
	<javascript: '
	var start= +new Date();
	for(var i=this.iterations|0;i>0;--i){aBlock()};
	return +new Date()-start;'>
]

{ #category : #public }
PjTimingPlatformApp class >> timeNull: nullBlock nonOptimized: nonBlock optimized: optBlock [
	| nullTime nonTime optTime |
	iterations := 100.
	self findBaseIterations: nonBlock and: optBlock min: 400.
	minimumTrials := 3.
	nullTime := self findStableTiming: nullBlock.
	nonTime := self findStableTiming: nonBlock.
	optTime := self findStableTiming: optBlock.
	^ JSON stringify: { nullTime. nonTime. optTime }
]
