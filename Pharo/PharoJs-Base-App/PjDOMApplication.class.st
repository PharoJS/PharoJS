"
I am the class that all client-side PharoJS applications should extend.

I contain methods that Browser and PhoneGap applications have in common.
"
Class {
	#name : #PjDOMApplication,
	#superclass : #PjApplication,
	#traits : 'PjTDomController',
	#classTraits : 'PjTDomController classTrait',
	#pools : [
		'PjDomGlobals'
	],
	#classInstVars : [
		'cssFile',
		'htmlFile'
	],
	#category : #'PharoJs-Base-App'
}

{ #category : #description }
PjDOMApplication class >> appClasses [
	<pharoJsSkip>
	^super appClasses, { PjHTMLCollection. PjNodeList}
]

{ #category : #description }
PjDOMApplication class >> setupCode [
	<pharoJsSkip>
	^super setupCode, 'var global=global||this'
]

{ #category : #accessing }
PjDOMApplication >> document [
 ^document
]

{ #category : #'start-stop' }
PjDOMApplication >> start [
	super start.
	self subscribeToDeviceEvents
]

{ #category : #'initialize-release' }
PjDOMApplication >> subscribeToDeviceEvents [
	^self
]
