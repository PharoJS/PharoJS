Class {
	#name : #PjRecord,
	#superclass : #Object,
	#instVars : [
		'id',
		'content'
	],
	#category : #'PharoJsBridge-Kernel'
}

{ #category : #accessing }
PjRecord >> content [
	^ content
]

{ #category : #accessing }
PjRecord >> content: anObject [
	content := anObject
]

{ #category : #accessing }
PjRecord >> id [
	^ id
]

{ #category : #accessing }
PjRecord >> id: anObject [
	id := anObject
]
