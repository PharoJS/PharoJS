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

{ #category : #'default instance' }
PjMessageDeleteGlobalVar >> deleteGlobalVarNamed: aVarName [
	<javascript:
	'var obj = global[aVarName];
	if (obj) {
		obj.$_jsName = undefined;
		if (aVarName)
			delete global[aVarName]
	}'>
]

{ #category : #public }
PjMessageDeleteGlobalVar >> evaluateInContext: aMessageContext [
	self deleteGlobalVarNamed: self varName
]

{ #category : #accessing }
PjMessageDeleteGlobalVar >> varName [
	^ varName
]

{ #category : #accessing }
PjMessageDeleteGlobalVar >> varName: anObject [
	varName := anObject
]
