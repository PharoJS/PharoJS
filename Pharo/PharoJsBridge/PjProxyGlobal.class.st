"
I am a proxy for a Javascript named global, such as document, Math, console
"
Class {
	#name : #PjProxyGlobal,
	#superclass : #PjProxy,
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #accessing }
PjProxyGlobal class >> allJavascriptGlobals [
	^ self withAllSubclasses flatCollectAsSet: [: class |
		class allInstances collect: #asJSON]
]

{ #category : #'class initialization' }
PjProxyGlobal class >> initialize [
	PjJavascriptGlobals withAllSubclassesDo: [ : pool |
		pool classVarNames do: [ : varName |
			pool classVarNamed: varName put: (
				self newProxyNamed: varName onBridge: nil) ]
	 ]
]

{ #category : #printing }
PjProxyGlobal >> printOn: aStream [
	aStream
		nextPutAll: 'a Proxy for ';
		nextPutAll: jsName

]
