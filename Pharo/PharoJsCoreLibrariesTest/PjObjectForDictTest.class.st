Class {
	#name : #PjObjectForDictTest,
	#superclass : #Object,
	#instVars : [
		'data'
	],
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #'instance creation' }
PjObjectForDictTest class >> data: anObject [
	^self new
		data: anObject;
		yourself
]

{ #category : #comparing }
PjObjectForDictTest >> = other [
	^data = other data
]

{ #category : #accessing }
PjObjectForDictTest >> data [
	^ data
]

{ #category : #accessing }
PjObjectForDictTest >> data: anObject [
	data := anObject
]

{ #category : #comparing }
PjObjectForDictTest >> hash [
	^data hash
]
