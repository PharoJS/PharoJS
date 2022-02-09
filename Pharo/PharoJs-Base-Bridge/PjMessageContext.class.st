Class {
	#name : #PjMessageContext,
	#superclass : #Object,
	#instVars : [
		'websocketDelegate'
	],
	#category : #'PharoJs-Base-Bridge-Messages'
}

{ #category : #accessing }
PjMessageContext >> websocketDelegate [

	^ websocketDelegate
]

{ #category : #accessing }
PjMessageContext >> websocketDelegate: anObject [

	websocketDelegate := anObject
]
