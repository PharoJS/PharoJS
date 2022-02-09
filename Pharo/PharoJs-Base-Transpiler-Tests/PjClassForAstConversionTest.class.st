"
I contain methods to use as sources for various tests in PjTranspilationTests
"
Class {
	#name : #PjClassForAstConversionTest,
	#superclass : #Object,
	#category : #'PharoJs-Base-Transpiler-Tests-Support'
}

{ #category : #'test method' }
PjClassForAstConversionTest >> basic1 [
	1
]

{ #category : #'test method' }
PjClassForAstConversionTest >> basic2 [
	^ 1
]

{ #category : #'test method' }
PjClassForAstConversionTest >> basic3 [
	<javascript: 'return 3'>
	^ (2 ifTrue: [^1] ifFalse: [3]) ifTrue: [ 2 ] ifFalse: [ 1 ]
]

{ #category : #'test method' }
PjClassForAstConversionTest >> basic4 [
	3.
	[ 2. 1 ]
]

{ #category : #'test method' }
PjClassForAstConversionTest >> basic5 [
	3.
	^ [ 2. 1 ]
]

{ #category : #'test method' }
PjClassForAstConversionTest >> basic6 [
	[ 2. 1 ].
	3
]

{ #category : #'test method' }
PjClassForAstConversionTest >> return1 [
	3.
	2.
	1 ifTrue: [ ^ 2 ] ifFalse: [ 1 ]
]

{ #category : #'test method' }
PjClassForAstConversionTest >> return2 [
	3.
	2.
	1 ifTrue: [ ^ 2 ] ifFalse: [ ^ 1 ]
]

{ #category : #'test method' }
PjClassForAstConversionTest >> return3 [
	3.
	2.
	^ 1 ifTrue: [ 2 ] ifFalse: [ 1 ]
]

{ #category : #'test method' }
PjClassForAstConversionTest >> return4 [
	3.
	2.
	^ (2 ifTrue: [^self] ifFalse: [3]) ifTrue: [ 2 ] ifFalse: [ 1 ]
]
