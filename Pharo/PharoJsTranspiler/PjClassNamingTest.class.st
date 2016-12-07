Class {
	#name : #PjClassNamingTest,
	#superclass : #TestCase,
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #testing }
PjClassNamingTest >> testClassNeedsCreation [
	self deny: Object needsClassDefinition.
	self deny: BlockClosure needsClassDefinition.
	self assert: UndefinedObject needsClassDefinition.
]
