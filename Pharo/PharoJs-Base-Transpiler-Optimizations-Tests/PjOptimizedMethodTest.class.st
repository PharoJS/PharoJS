Class {
	#name : 'PjOptimizedMethodTest',
	#superclass : 'PjBridgeTestCase',
	#category : 'PharoJs-Base-Transpiler-Optimizations-Tests-Tests',
	#package : 'PharoJs-Base-Transpiler-Optimizations-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PjOptimizedMethodTest >> testShouldReturnTrue [
	self assertEquivalent: [|d|
		d := PjOptimizedMethods new.
		d shouldReturnTrue].
]

{ #category : 'tests' }
PjOptimizedMethodTest >> testShouldReturnTrue2 [
	self assertEquivalent: [|d|
		d := PjOptimizedMethods new.
		d shouldReturnTrue2].
]
