Class {
	#name : 'PjMessageGetKeys',
	#superclass : 'PjMessageS2c',
	#instVars : [
		'proxyInfo'
	],
	#category : 'PharoJs-Base-Bridge-Messages',
	#package : 'PharoJs-Base-Bridge',
	#tag : 'Messages'
}

{ #category : 'public' }
PjMessageGetKeys >> evaluateInContext: aMessageContext [

	| wsd responseMsg jsObject assocs |
	wsd := aMessageContext websocketDelegate.
	responseMsg := PjMessageGetKeysResponse newWithId.
	jsObject := globalThis instVarNamed: self proxyInfo globalName.
	assocs := self keyValuePairsOf: jsObject.
	responseMsg contents: assocs.
	responseMsg inResponseToId: self id.
	wsd tryToSendMessage: responseMsg
]

{ #category : 'public' }
PjMessageGetKeys >> keyValuePairsOf: anObject [

	| results |
	results := OrderedCollection new.
	anObject allEnumeratableKeysDo: [ :key | 
		| value valueString |
		value := anObject instVarNamed: key.
		valueString := self stringFrom: value for: anObject.
		results add: key -> valueString ].
	^ results
]

{ #category : 'printing' }
PjMessageGetKeys >> logDescription [

	^ String streamContents: [ :ws | 
		  ws nextPutAll: self class name.
		  ws nextPutAll: ' id: '.
		  ws nextPutAll: self id printString.
		  self proxyInfo ifNotNil: [ :pi | 
			  ws nextPutAll: ' proxyInfo: '.
			  ws nextPutAll: pi logDescription ] ]
]

{ #category : 'accessing' }
PjMessageGetKeys >> proxyInfo [

	^ proxyInfo
]

{ #category : 'accessing' }
PjMessageGetKeys >> proxyInfo: anObject [

	proxyInfo := anObject
]

{ #category : 'public' }
PjMessageGetKeys >> stringFrom: value for: anObject [
	| head body |
	value == anObject  ifTrue: [ ^'self' ].
	head := value printString.
	body := [value asPhxJsonString] on: Error do: ['{...}'].
	(body beginsWith: ${) ifFalse: [ ^head ].
	^head, ' ', body
]
