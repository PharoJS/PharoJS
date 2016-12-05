Class {
	#name : #PjIfNotNilIfNilOptimization,
	#superclass : #PjIfNilIfNotNilOptimization,
	#category : #'PharoJsTranspilerOptimization-Optimizations'
}

{ #category : #converting }
PjIfNotNilIfNilOptimization >> convertReceiver: receiverNode args: aCollection [ 
	^super convertReceiver: receiverNode args: aCollection reversed
]

{ #category : #accessing }
PjIfNotNilIfNilOptimization >> selector [
	^#ifNotNil:ifNil:
]
