Class {
	#name : #PjAliasTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

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
