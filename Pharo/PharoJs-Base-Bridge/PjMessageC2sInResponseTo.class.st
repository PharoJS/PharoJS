Class {
	#name : #PjMessageC2sInResponseTo,
	#superclass : #PjMessageC2s,
	#instVars : [
		'inResponseToId'
	],
	#category : #'PharoJs-Base-Bridge-Messages'
}

{ #category : #accessing }
PjMessageC2sInResponseTo >> inResponseToId [

	^ inResponseToId
]

{ #category : #accessing }
PjMessageC2sInResponseTo >> inResponseToId: anObject [

	inResponseToId := anObject
]
