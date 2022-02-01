Class {
	#name : #PjObjectForTestingAsJsObject,
	#superclass : #Object,
	#instVars : [
		'plainArray',
		'associationArray',
		'dict',
		'objectNoIvs',
		'objectWithIvs'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #'instance creation' }
PjObjectForTestingAsJsObject class >> from: anAssociationArray [
	^self new
		from: anAssociationArray;
		yourself
]

{ #category : #initialization }
PjObjectForTestingAsJsObject >> from: anAssociationArray [
	anAssociationArray asDictionary keysAndValuesDo: [ : key :value|
		self instVarNamed: key put: value]
]
