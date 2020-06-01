Class {
	#name : #PjMessageEvaluationResponse,
	#superclass : #PjMessageC2s,
	#instVars : [
		'inResponseToId'
	],
	#category : #'PharoJsBridge-Messages'
}

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
	^ [ PjJavascriptError
		signal: 'unrecognized response from browser:' , contents ]
]

{ #category : #accessing }
PjMessageEvaluationResponse >> inResponseToId [
	^ inResponseToId
]

{ #category : #accessing }
PjMessageEvaluationResponse >> inResponseToId: anObject [
	inResponseToId := anObject
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
			ws
				nextPutAll:
					(self contents
						ifNotNil: [ :c | 
							c isString
								ifTrue: [ c ]
								ifFalse: [ c logDescription ] ]
						ifNil: [ '-' ]) ]
]

{ #category : #printing }
PjMessageEvaluationResponse >> printOn: ws [
	<pharoJsSkip>
	super printOn: ws.
	ws space.
	ws << 'ir2id: '.
	ws << (self inResponseToId ifNil: ['-']).
	ws space.
	ws << self contents
]
