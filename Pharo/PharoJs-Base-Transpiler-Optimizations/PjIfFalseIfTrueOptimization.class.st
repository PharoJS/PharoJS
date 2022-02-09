Class {
	#name : #PjIfFalseIfTrueOptimization,
	#superclass : #PjIfTrueIfFalseOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjIfFalseIfTrueOptimization >> convertReceiver: receiverNode args: aCollection [ 
	^super convertReceiver: receiverNode args: aCollection reversed
]

{ #category : #accessing }
PjIfFalseIfTrueOptimization >> selector [
	^#ifFalse:ifTrue:
]
