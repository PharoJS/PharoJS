Class {
	#name : #PjMessageGetKeys,
	#superclass : #PjMessageS2c,
	#instVars : [
		'proxyInfo'
	],
	#category : #'PharoJs-Base-Bridge-Messages'
}

{ #category : #public }
PjMessageGetKeys >> evaluateInContext: aMessageContext [
	| wsd responseMsg jsObject assocs |
	wsd := aMessageContext websocketDelegate.
	responseMsg := PjMessageGetKeysResponse newWithId.
	jsObject := global instVarNamed: self proxyInfo globalName.
	console log: 'get keys object:' with: jsObject.
	assocs := self keyValuePairsOf: jsObject.
	console log: 'get keys assocs:' with: assocs.
	responseMsg contents: assocs.
	responseMsg inResponseToId: self id.
	wsd tryToSendMessage: responseMsg
]

{ #category : #public }
PjMessageGetKeys >> keyValuePairsOf: anObject [
	| results |
	results := OrderedCollection new.
	anObject
		allEnumeratableKeysDo: [ :key | 
			| value |
			value := anObject instVarNamed: key.
			results add: key -> (JSON stringify: value) ] .
	^ results
]

{ #category : #printing }
PjMessageGetKeys >> logDescription [
	^ String
		streamContents: [ :ws | 
			ws nextPutAll: self class name.
			ws nextPutAll: ' id: '.
			ws nextPutAll: self id printString.
			self proxyInfo
				ifNotNil: [ :pi | 
					ws nextPutAll: ' proxyInfo: '.
					ws nextPutAll: pi logDescription ] ]
]

{ #category : #accessing }
PjMessageGetKeys >> proxyInfo [
	^ proxyInfo
]

{ #category : #accessing }
PjMessageGetKeys >> proxyInfo: anObject [
	proxyInfo := anObject
]
