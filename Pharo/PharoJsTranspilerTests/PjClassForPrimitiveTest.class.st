Class {
	#name : #PjClassForPrimitiveTest,
	#superclass : #Object,
	#category : #'PharoJsTranspilerTests-Support'
}

{ #category : #any }
PjClassForPrimitiveTest >> + aNumber [ 
	"Primitive. Answer the sum of the receiver and aNumber. Essential.
	Fail if the argument is not a Float. See Object documentation
	whatIsAPrimitive."

	<primitive: 41>
	^ aNumber adaptToFloat: self andSend: #+
]
