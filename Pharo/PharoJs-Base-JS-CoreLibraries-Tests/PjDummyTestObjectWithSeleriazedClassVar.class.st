Class {
	#name : #PjDummyTestObjectWithSeleriazedClassVar,
	#superclass : #Object,
	#classInstVars : [
		'#toBeSerialized => JavascriptSerializedInstanceVariableSlot2'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #'class initialization' }
PjDummyTestObjectWithSeleriazedClassVar class >> initialize [
	toBeSerialized := 'stuff'
]