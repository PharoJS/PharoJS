Class {
	#name : #PjMessageResponse,
	#superclass : #PjMessage,
	#instVars : [
		'inResponseToId'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #public }
PjMessageResponse >> contentsObject [
	<pharoJsSkip>
	^ PjSTONReader from: self contents
]

{ #category : #public }
PjMessageResponse >> evaluateInContext: aMessageContext [
	"self subclassResponsibility "
]

{ #category : #accessing }
PjMessageResponse >> inResponseToId [
	^ inResponseToId
]

{ #category : #accessing }
PjMessageResponse >> inResponseToId: anObject [
	inResponseToId := anObject
]

{ #category : #printing }
PjMessageResponse >> logDescription [
	^ String
		streamContents: [ :ws | 
			ws nextPutAll: self class name.
			ws nextPutAll: ' id: '.
			ws nextPutAll: self id asString.
			ws nextPutAll: ' inResponseToId: '.
			ws nextPutAll: self inResponseToId asString.
			ws nextPutAll: ' contents: '.
			ws nextPutAll: self contents ]
]

{ #category : #testing }
PjMessageResponse >> needsToBeQueued [
	| obj |
	obj := self contentsObject.
	obj isDictionary
		ifFalse: [ ^ true ].
	(obj includesKey: #inspect)
		ifTrue: [ ^ false ].
	(obj includesKey: #cb)
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #testing }
PjMessageResponse >> processCallbackWithBridge: aBridge [
	<pharoJsSkip>
	| array proxy args |
	array := self contentsObject at: #cb.
	proxy := PjProxy proxyNamed: array first onBridge: aBridge.
	args := array allButFirst
		collect: [ :each | aBridge evalResult: self contents parsed: each ].
	aBridge
		scheduleCallback: [ proxy runBlockClosure: args first with: args second ]
]

{ #category : #testing }
PjMessageResponse >> processInspectWithBridge: aBridge [
	<pharoJsSkip>
	| proxy |
	proxy := aBridge
		evalResult: self contents
		parsed: (self contentsObject at: #inspect).
	aBridge scheduleCallback: [ proxy inspect ]
]

{ #category : #testing }
PjMessageResponse >> processWithBridge: aBridge [
	<pharoJsSkip>
	(self contentsObject includesKey: #inspect)
		ifTrue: [ self processInspectWithBridge: aBridge ].
	(self contentsObject includesKey: #cb)
		ifTrue: [ self processCallbackWithBridge: aBridge ]
]
