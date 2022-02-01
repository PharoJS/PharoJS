Class {
	#name : #PjClassNamingTest,
	#superclass : #TestCase,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #tests }
PjClassNamingTest >> testClassNeedsCreation [
	self deny: Object needsClassDefinition.
	self deny: BlockClosure needsClassDefinition.
	self assert: UndefinedObject needsClassDefinition.
]
