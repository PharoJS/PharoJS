Class {
	#name : #PjMessageEvaluationResponse,
	#superclass : #PjMessageC2sInResponseTo,
	#category : #'PharoJsBridge-Messages'
}

{ #category : #printing }
PjMessageEvaluationResponse >> contentsDescription [
	<javascript: 'return JSON.stringify(contents)'>
	^ contents displayString
]

{ #category : #public }
PjMessageEvaluationResponse >> contentsObject [
	<pharoJsSkip>
	^ self contents isString
		ifTrue: [ PjSTONReader from: self contents ]
		ifFalse: [ self contents ]
]

{ #category : #public }
PjMessageEvaluationResponse >> getValueWithBridge: aBridge [
	<PjTodo: 'Too much testing going here, further refactoring needed'>
	| value |
	value := self contentsObject.
	value isLiteral
		ifTrue: [ ^ value ].
	value isNumber
		ifTrue: [ ^ value ].
	value isDictionary
		ifTrue: [ value isEmpty
				ifTrue: [ ^ nil ] ].
	(value isKindOf: PjProxyInfo)
		ifTrue: [ ^ value proxyForBridge: aBridge ].
	Error signal: 'unrecognized response from browser:' , contents
]

{ #category : #printing }
PjMessageEvaluationResponse >> logDescription [
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
			ws nextPutAll: self contentsDescription ]
]

{ #category : #printing }
PjMessageEvaluationResponse >> printOn: ws [
	<pharoJsSkip>
	super printOn: ws.
	ws space.
	ws << 'ir2id: '.
	ws << (self inResponseToId ifNil: ['-']).
	ws << 'contents: '.
	ws << self contentsDescription
]
