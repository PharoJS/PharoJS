Class {
	#name : #PjSharedPoolForTest,
	#superclass : #SharedPool,
	#classVars : [
		'A',
		'B',
		'C',
		'X'
	],
	#category : #'PharoJs-Base-Transpiler-Tests-Support'
}

{ #category : #'initialization-release' }
PjSharedPoolForTest class >> initialize [
	A := #sharedA.
	B := #sharedB.
	C := #sharedC.
]
