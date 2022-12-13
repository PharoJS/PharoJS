Class {
	#name : #PjAliasTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #running }
PjAliasTest >> loadClass: aClass [
	self bridge loadClass: aClass
]

{ #category : #running }
PjAliasTest >> setUp [

	super setUp.
	self bridge loadClass: PjClassForTranspilationTest
]

{ #category : #tests }
PjAliasTest >> testAlias2Methods0Arg [

	self
		assert: [ PjClassForTranspilationTest new alias2 ]
		evaluatesTo: 21.
	self
		assert: [ PjClassForTranspilationTest new alias2Caller ]
		evaluatesTo: 42
]

{ #category : #tests }
PjAliasTest >> testAliasMethod0Args [

	self assert:	 [ PjClassForTranspilationTest new aliasCaller ] evaluatesTo: 42.
	self assert:	 [ PjClassForTranspilationTest new alias ] evaluatesTo: 42.
	self assert:	 [ PjClassForTranspilationTest new aliasSpecialNameCaller ] evaluatesTo: 42.
	self assert:	 [ PjClassForTranspilationTest new aliasSpecialName ] evaluatesTo: 42.
]

{ #category : #tests }
PjAliasTest >> testAliasMethod1Arg [

	self assert:	 [ PjClassForTranspilationTest new alias1Caller: 41 ] evaluatesTo: 42.
	self assert:	 [ PjClassForTranspilationTest new alias1: 41 ] evaluatesTo: 42
]

{ #category : #tests }
PjAliasTest >> testClassMethod1AliasInExtensionClass [

	self loadClass: PjExtensionClassForAliasTest.
	self assert: [ Object classM1 ] evaluatesTo: 'classM1'.
	self assert: [ Object classM1alias ] evaluatesTo: 'classM1'
]

{ #category : #tests }
PjAliasTest >> testClassMethod2AliasesInExtensionClass [

	self loadClass: PjExtensionClassForAliasTest.
	self assert: [ Object classM2 ] evaluatesTo: 'classM2'.
	self assert: [ Object classM2alias1 ] evaluatesTo: 'classM2'.
	self assert: [ Object classM2alias2 ] evaluatesTo: 'classM2'.
]

{ #category : #tests }
PjAliasTest >> testInstanceMethod1AliasInExtensionClass [
	self loadClass: PjExtensionClassForAliasTest.
	self
		assert: [ Object new m1 ]
		evaluatesTo: 'instanceM1'.
	self
		assert: [ Object new m1alias ]
		evaluatesTo: 'instanceM1'.

]

{ #category : #tests }
PjAliasTest >> testInstanceMethod3AliasesInExtensionClass [

	self loadClass: PjExtensionClassForAliasTest.
	self assert: [ Object new m2 ] evaluatesTo: 'instanceM2'.
	self assert: [ Object new m2alias1 ] evaluatesTo: 'instanceM2'.
	self assert: [ Object new m2alias2 ] evaluatesTo: 'instanceM2'.
	self assert: [ Object new m2alias3 ] evaluatesTo: 'instanceM2'
]
