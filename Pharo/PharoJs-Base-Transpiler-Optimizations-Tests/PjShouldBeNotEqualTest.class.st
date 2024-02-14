Class {
	#name : #PjShouldBeNotEqualTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Tests-Tests'
}

{ #category : #'as yet unclassified' }
PjShouldBeNotEqualTest >> test_true_is_string [

	| var1 var2 |
	var1 := true.
	var2 := #Person.
	self
		assert: [
			var1 = var2
				ifFalse: [ #notEqual ]
				ifTrue: [ #equal ] ]
		evaluatesTo: #notEqual
]
