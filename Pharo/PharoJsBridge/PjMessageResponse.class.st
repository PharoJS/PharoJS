Class {
	#name : #PjMessageResponse,
	#superclass : #PjMessageC2s,
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

{ #category : #accessing }
PjMessageResponse >> inResponseToId [
	^ inResponseToId
]

{ #category : #accessing }
PjMessageResponse >> inResponseToId: anObject [
	inResponseToId := anObject
]

{ #category : #testing }
PjMessageResponse >> isCallback [
	| obj |
	obj := self contentsObject.
	obj isDictionary
		ifFalse: [ ^ false ].
	(obj includesKey: #inspect)
		ifTrue: [ ^ true ].
	(obj includesKey: 'cb')
		ifTrue: [ ^ true ].
	^ false
]

{ #category : #printing }
PjMessageResponse >> logDescription [
	^ String
		streamContents: [ :ws | 
			ws nextPutAll: self class name.
			ws nextPutAll: ' id: '.
			ws nextPutAll: self id asString.
			ws nextPutAll: ' inResponseToId: '.
			ws
				nextPutAll:
					(self inResponseToId
						ifNotNil: [ :aNumber | aNumber asString ]
						ifNil: [ '-' ]).
			ws nextPutAll: ' contents: '.
			ws nextPutAll: (self contents ifNil: [ '-' ]) ]
]

{ #category : #printing }
PjMessageResponse >> printOn: ws [
	<pharoJsSkip>
	super printOn: ws.
	ws space.
	ws << 'ir2id: '.
	ws << (self inResponseToId ifNil: ['-']).
	ws space.
	ws << self contents
]

{ #category : #testing }
PjMessageResponse >> processCallbackWithBridge: aBridge [
	<pharoJsSkip>
	(self contentsObject includesKey: #inspect)
		ifTrue: [ self processInspectWithBridge: aBridge ].
	(self contentsObject includesKey: #cb)
		ifTrue: [ self processCbWithBridge: aBridge ]
]

{ #category : #testing }
PjMessageResponse >> processCbWithBridge: aBridge [
	<pharoJsSkip>
	| array proxy args |
	"will have its own dedicated PjMessaga class"
	array := self contentsObject at: #cb.
	proxy := PjProxy proxyNamed: array first onBridge: aBridge.
	args := array allButFirst
		collect: [ :each | aBridge evalResult: self contents parsed: each ].
   proxy runBlockClosure: args first with: args second
]

{ #category : #testing }
PjMessageResponse >> processInspectWithBridge: aBridge [
	<pharoJsSkip>
	| proxy |
		"will have its own dedicated PjMessaga class"
	proxy := aBridge
		evalResult: self contents
		parsed: (self contentsObject at: #inspect).
	 proxy inspect 
]
