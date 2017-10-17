"
I am a transpiler that can be controlled to support the timing application/
"
Class {
	#name : #PjTimingTestTranspiler,
	#superclass : #PjDependentTranspiler,
	#instVars : [
		'delayDNU'
	],
	#category : #'PharoJsTiming-Timing'
}

{ #category : #accessing }
PjTimingTestTranspiler >> delayDNU [
	^delayDNU
]

{ #category : #accessing }
PjTimingTestTranspiler >> delayDNU: anObject [
	delayDNU := anObject
]

{ #category : #transpiling }
PjTimingTestTranspiler >> generateCodeStringFrom: jsAst [
	self delayDNU ifFalse: [
		self enableWriteDnuDuring: [self writeDnuList]].
	generator asString: jsAst on: self jsStream.

]

{ #category : #'initailize-release' }
PjTimingTestTranspiler >> initialize [
	super initialize.
	self delayDNU: false.
]
