Class {
	#name : #PjOptimizedMethodTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #tests }
PjOptimizedMethodTest >> testShouldReturnTrue [
	self assertEquivalent: [|d|
		d := PjOptimizedMethods new.
		d shouldReturnTrue].
]

{ #category : #tests }
PjOptimizedMethodTest >> testShouldReturnTrue2 [
	self assertEquivalent: [|d|
		d := PjOptimizedMethods new.
		d shouldReturnTrue2].
]
