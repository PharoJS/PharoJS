Class {
	#name : #PjMessageEvaluateResult,
	#superclass : #PjMessageC2s,
	#instVars : [
		'inResponseToId'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #public }
PjMessageEvaluateResult >> contentsObject [
	<pharoJsSkip>
	^ self contents isString
		ifTrue: [ PjSTONReader from: self contents ]
		ifFalse: [ self contents ]
]

{ #category : #accessing }
PjMessageEvaluateResult >> inResponseToId [
	^ inResponseToId
]

{ #category : #accessing }
PjMessageEvaluateResult >> inResponseToId: anObject [
	inResponseToId := anObject
]

{ #category : #printing }
PjMessageEvaluateResult >> logDescription [
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
PjMessageEvaluateResult >> printOn: ws [
	<pharoJsSkip>
	super printOn: ws.
	ws space.
	ws << 'ir2id: '.
	ws << (self inResponseToId ifNil: ['-']).
	ws space.
	ws << self contents
]
