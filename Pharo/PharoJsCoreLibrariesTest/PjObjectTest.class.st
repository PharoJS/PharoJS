Class {
	#name : #PjObjectTest,
	#superclass : #PjBridgeTestCase,
	#category : #PharoJsCoreLibrariesTest
}

{ #category : #testing }
PjObjectTest >> testPrintString [
	self assert: [ Object new printString ] evaluatesTo: 'an Object'.
	self assert: [ PjSet new printString ] evaluatesTo: 'a PjSet'.
	self assert: [ 'hello world' printString ] evaluatesTo: 'hello world'.
	self assert: [ 123 printString ] evaluatesTo: '123'.
	self assert: [ true printString ] evaluatesTo: 'true'.
	

]
