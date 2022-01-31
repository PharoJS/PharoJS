Class {
	#name : #PjClassForPrimitiveFailingTest,
	#superclass : #Object,
	#category : #'PharoJs-Base-Transpiler-Tests-Support'
}

{ #category : #any }
PjClassForPrimitiveFailingTest >> * aNumber [ 
	"Primitive. Answer the sum of the receiver and aNumber. Essential.
	Fail if the argument is not a Float. See Object documentation
	whatIsAPrimitive."

	<primitive: 49>
]
