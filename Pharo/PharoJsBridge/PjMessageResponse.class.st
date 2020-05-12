Class {
	#name : #PjMessageResponse,
	#superclass : #PjMessage,
	#instVars : [
		'inResponseToId'
	],
	#category : #'PharoJsBridge-Proxy'
}

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
			ws nextPutAll: self id.
			ws nextPutAll: ' inResponseToId: '.
			ws nextPutAll: self inResponseToId.
			ws nextPutAll: ' contents: '.
			ws nextPutAll: self contents ]
]
