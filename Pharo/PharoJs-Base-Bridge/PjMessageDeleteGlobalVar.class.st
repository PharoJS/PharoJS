Class {
	#name : #PjMessageDeleteGlobalVar,
	#superclass : #PjMessageS2c,
	#instVars : [
		'varName'
	],
	#category : #'PharoJs-Base-Bridge-Messages'
}

{ #category : #'instance creation' }
PjMessageDeleteGlobalVar class >> newForVarName: jsName [

	^ self new
		  varName: jsName;
		  yourself
]

{ #category : #public }
PjMessageDeleteGlobalVar >> evaluateInContext: aMessageContext [
	<PjTodo: 'should use PjProxyInfo'>
	
	PjProxyManager deleteGlobalVarNamed: self varName
]

{ #category : #public }
PjMessageDeleteGlobalVar >> logDescription [

	^ String streamContents: [ :ws | 
		  ws nextPutAll: self class name.
		  ws nextPutAll: ' id: '.
		  ws nextPutAll:
			  (self id ifNil: [ '-' ] ifNotNil: [ self id printString ]).
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
