"
I contain utility methods for transpilation tests
"
Class {
	#name : #PjTranspilationTest,
	#superclass : #TestCase,
	#traits : 'PjTJavascriptCodeAnalyser',
	#classTraits : 'PjTJavascriptCodeAnalyser classTrait',
	#instVars : [
		'transpiler',
		'classToTranspile'
	],
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #testing }
PjTranspilationTest >> assertStBlock: aBlock convertsTo: expectedJsString [
	self assert: (transpiler convertToJs: aBlock) equals: expectedJsString
]

{ #category : #accessing }
PjTranspilationTest >> classToTranspile [
	^ classToTranspile
]

{ #category : #accessing }
PjTranspilationTest >> classToTranspile: aClass [
	classToTranspile := aClass
]

{ #category : #accessing }
PjTranspilationTest >> classVariablesHolderName [
	^ PjStringGenerator classVariablesHolderName
]

{ #category : #converting }
PjTranspilationTest >> convertClass: aClass [
	self classToTranspile: aClass.
	^ transpiler convertToJs: aClass
]

{ #category : #accessing }
PjTranspilationTest >> lineEnding [
	^self transpilerClass lineEnding
]

{ #category : #accessing }
PjTranspilationTest >> method: aString [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
PjTranspilationTest >> nilInJavascript [
	^PjStringGenerator nilInJavascript
]

{ #category : #accessing }
PjTranspilationTest >> nilTestFunctionName [
	^PjStringGenerator nilTestFunctionName
]

{ #category : #'as yet unclassified' }
PjTranspilationTest >> selectorsPrefix [
	^PjTranspiler pharoJsSelectorPrefix
]

{ #category : #running }
PjTranspilationTest >> setUp [
	super setUp.
	transpiler := self transpilerClass new.
]

{ #category : #accessing }
PjTranspilationTest >> transpilerClass [
	^PjTranspiler 
]

{ #category : #writing }
PjTranspilationTest >> writeJsSelector: aSelector onStream: aStream [
	| isBinary |
	(aSelector beginsWith: self jsNativePrefix) ifTrue: [ 
			^ aStream nextPutAll: ((aSelector keywords first allButFirst: self jsNativePrefix size) copyWithout: $:) ].
	isBinary := aSelector isBinary.
	aStream nextPutAll: self pharoJsSelectorPrefix.
	aSelector do:[ :each | 
			self writeSelectorChar: each on: aStream isInBinarySelector: isBinary ]
]
