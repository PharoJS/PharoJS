"
I am an optimizatino to the unary message not
"
Class {
	#name : #PjNotOptimization,
	#superclass : #PjSpecialMessageConversion,
	#category : #'PharoJsTranspiler-MessageConversions'
}

{ #category : #converting }
PjNotOptimization >> convertReceiver: receiver args: args [
	^ (self visit: receiver) not
]

{ #category : #accessing }
PjNotOptimization >> selector [
	^#not
]
