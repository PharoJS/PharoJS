"
I am a weird conversion to provide a way for an event handle to reference the 'this' value which refers to the object to which the event handler was attached.'
"
Class {
	#name : #PjJsThisConversion,
	#superclass : #PjSpecialMessageConversion,
	#category : #'PharoJs-Base-Transpiler-MessageConversions'
}

{ #category : #converting }
PjJsThisConversion >> convertReceiver: receiver args: args [
	^ PjGlobalNode identifier: #this
]

{ #category : #accessing }
PjJsThisConversion >> selector [
	^#js_this
]
