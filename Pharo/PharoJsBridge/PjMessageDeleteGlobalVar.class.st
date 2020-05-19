Class {
	#name : #PjMessageDeleteGlobalVar,
	#superclass : #PjMessage,
	#instVars : [
		'varName'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #'as yet unclassified' }
PjMessageDeleteGlobalVar class >> newForVarName: jsName [
	^ self new
		varName: jsName;
		yourself
]

{ #category : #public }
PjMessageDeleteGlobalVar >> evaluateInContext: aMessageContext [
	PjProxyManager deleteGlobalVarNamed: self varName
]

{ #category : #public }
PjMessageDeleteGlobalVar >> logDescription [
	^ String
		streamContents: [ :ws | 
			ws nextPutAll: self class name.
			ws nextPutAll: ' id: '.
			ws nextPutAll: self id printString.
			ws nextPutAll: ' varName: '.
			ws nextPutAll: self varName ]
]

{ #category : #accessing }
PjMessageDeleteGlobalVar >> varName [
	^ varName
]

{ #category : #accessing }
PjMessageDeleteGlobalVar >> varName: anObject [
	varName := anObject
]
