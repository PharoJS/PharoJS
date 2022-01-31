Class {
	#name : #PjClassNamingTest,
	#superclass : #TestCase,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #testing }
PjClassNamingTest >> testClassNeedsCreation [
	self deny: Object needsClassDefinition.
	self deny: BlockClosure needsClassDefinition.
	self assert: UndefinedObject needsClassDefinition.
]
