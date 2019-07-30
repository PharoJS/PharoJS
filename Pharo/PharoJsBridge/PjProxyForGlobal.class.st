"
I am a proxy for a Javascript named global, such as document, Math, console
"
Class {
	#name : #PjProxyForGlobal,
	#superclass : #PjProxy,
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #accessing }
PjProxyForGlobal class >> allJavascriptGlobals [
	^ self withAllSubclasses flatCollectAsSet: [: class |
		class allInstances collect: #asJSON]
]

{ #category : #'instance creation' }
PjProxyForGlobal class >> newProxyNamed: globalName [
	^self newProxyNamed: globalName onBridge: nil
]

{ #category : #printing }
PjProxyForGlobal >> printOn: aStream [
	aStream
		nextPutAll: 'a Proxy for ';
		nextPutAll: jsName

]
