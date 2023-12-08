Class {
	#name : #PjDummyTestObjectWithSeleriazedClassVar,
	#superclass : #Object,
	#classInstVars : [
		'#toBeSerialized => JavascriptSerializedInstanceVariableSlot'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #'class initialization' }
PjDummyTestObjectWithSeleriazedClassVar class >> initialize [

	self toBeSerialized: self pharoOnlyInitialization
]

{ #category : #'class initialization' }
PjDummyTestObjectWithSeleriazedClassVar class >> pharoOnlyInitialization [

	<javascript: 'return null'>
	^ 'stuff'
]

{ #category : #'class initialization' }
PjDummyTestObjectWithSeleriazedClassVar class >> toBeSerialized [
	^ toBeSerialized 
]

{ #category : #'class initialization' }
PjDummyTestObjectWithSeleriazedClassVar class >> toBeSerialized: anObject [

	<javascript: 'return null'>
	toBeSerialized := anObject
]
