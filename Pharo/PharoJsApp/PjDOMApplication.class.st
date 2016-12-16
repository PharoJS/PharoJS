"
I am the class that all client-side PharoJS applications should extend.

I contain methods that Browser and PhoneGap applications have in common.
"
Class {
	#name : #PjDOMApplication,
	#superclass : #PjApplication,
	#pools : [
		'PjDomGlobals'
	],
	#classInstVars : [
		'cssFile',
		'htmlFile'
	],
	#category : #PharoJsApp
}

{ #category : #description }
PjDOMApplication class >> setupCode [
	<pharoJsSkip>
	^'var global=global||this'
]

{ #category : #'manipulating DOM' }
PjDOMApplication >> domElementAt: elementId [
	^document getElementById: elementId
]

{ #category : #'manipulating DOM' }
PjDOMApplication >> domElementAt: elementId setAttribute: attributeName to: attributeValue [
	(self domElementAt: elementId) setAttribute: attributeName to: attributeValue
]

{ #category : #'manipulating DOM' }
PjDOMApplication >> hideDomElementAt: elementId [
	self domElementAt: elementId setAttribute: 'style' to: 'display:none;'
]

{ #category : #'manipulating DOM' }
PjDOMApplication >> replaceContentsOf: elementId with: aString [
	(self domElementAt: elementId) innerHTML: aString
]

{ #category : #'manipulating DOM' }
PjDOMApplication >> setClassOf: elementId to: attributeValue [
	^ self domElementAt: elementId setAttribute: 'class' to: attributeValue
]

{ #category : #'manipulating DOM' }
PjDOMApplication >> showDomElementAt: elementId [
	self domElementAt: elementId setAttribute: 'style' to: 'display:block;'
]

{ #category : #'initialize-release' }
PjDOMApplication >> subscribeToDeviceEvents [
	^self
]
