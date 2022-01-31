"
I optimize js_at: to Javascript object/array references.

Required by bootstrap code
"
Class {
	#name : #PjJsAtConversion,
	#superclass : #PjSpecialMessageConversion,
	#category : #'PharoJsTranspiler-MessageConversions'
}

{ #category : #converting }
PjJsAtConversion >> convertReceiver: receiver args: args [
	^PjFieldNode target: (self visit: receiver) selectorNode: (self visit: args first) isNonNil: true
]

{ #category : #accessing }
PjJsAtConversion >> selector [
	^ #js_at:
]
