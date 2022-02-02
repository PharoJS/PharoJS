"
I represent a message to be evaluated on the Javascript side.

I extend the standard Message class, with a receiver.

The transpiler converts me to Javascript in a special way.
"
Class {
	#name : #PjJavascriptMessage,
	#superclass : #Message,
	#instVars : [
		'receiverId'
	],
	#category : #'PharoJs-Base-Bridge-Kernel'
}

{ #category : #'instance creation' }
PjJavascriptMessage class >> receiverId: receiverId selector: selector arguments: arguments [
	^(self selector: selector arguments: arguments)
		receiverId: receiverId;
		yourself
]

{ #category : #converting }
PjJavascriptMessage >> asJsAstUsing: aConverter [

	^ aConverter convertJavascriptMessage: self
]

{ #category : #converting }
PjJavascriptMessage >> convertToJsUsing: aTranspiler [

	aTranspiler convertJavascriptMessage: self
]

{ #category : #accessing }
PjJavascriptMessage >> receiverId [
	^ receiverId
]

{ #category : #accessing }
PjJavascriptMessage >> receiverId: anObject [

	receiverId := anObject
]
