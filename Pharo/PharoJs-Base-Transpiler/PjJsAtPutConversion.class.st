"
I optimize js_at:put: to Javascript object/array references.

Required by bootstrap code
"
Class {
	#name : #PjJsAtPutConversion,
	#superclass : #PjJsAtConversion,
	#category : #'PharoJs-Base-Transpiler-MessageConversions'
}

{ #category : #converting }
PjJsAtPutConversion >> convertReceiver: receiver args: args [
	| reference |
	reference :=  super convertReceiver: receiver args: args.
	^ PjAssignNode target: reference expression: (self visit: args second)
]

{ #category : #accessing }
PjJsAtPutConversion >> selector [
	^ #js_at:put:
]
