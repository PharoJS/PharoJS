"
I represent the Javascript Error type.
"
Class {
	#name : #PjError,
	#superclass : #PjObject,
	#traits : 'PjTExtensionClass',
	#classTraits : 'PjTExtensionClass classTrait',
	#instVars : [
		'message'
	],
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'instance creation' }
PjError class >> signal [
	^self new signal
]

{ #category : #'instance creation' }
PjError class >> signal: aString [
	^self new signal: aString
]

{ #category : #accessing }
PjError >> messageText [
	^ message
]

{ #category : #accessing }
PjError >> messageText: anObject [
	message := anObject
]

{ #category : #signaling }
PjError >> signal [
	<javascript: 'throw this'>
]

{ #category : #signaling }
PjError >> signal: aString [
	self messageText: aString.
	^self signal.
]
