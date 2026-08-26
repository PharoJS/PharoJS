Class {
	#name : 'PjIfNotNilIfNilOptimization',
	#superclass : 'PjIfNilIfNotNilOptimization',
	#category : 'PharoJs-Base-Transpiler-Optimizations-Optimizations',
	#package : 'PharoJs-Base-Transpiler-Optimizations',
	#tag : 'Optimizations'
}

{ #category : 'converting' }
PjIfNotNilIfNilOptimization >> convertReceiver: receiverNode args: aCollection [ 
	^super convertReceiver: receiverNode args: aCollection reversed
]

{ #category : 'accessing' }
PjIfNotNilIfNilOptimization >> selector [
	^#ifNotNil:ifNil:
]
