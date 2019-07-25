Class {
	#name : #PjClassExtensionTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #accessing }
PjClassExtensionTranspilationTest >> classToTranspile [
	^ PjClassExtensionForTest
]

{ #category : #testing }
PjClassExtensionTranspilationTest >> testClassExtension [
	self deny: self jsCode includes: self classToTranspile name.
	self deny: self jsCode includes: 'function ', self classToTranspile name, '(){}'.
	self deny: self jsCode includes: 'function ', PjClassForTranspilationTest name, '(){}'.
	self assert: self jsCode includes: 'instanceMethod'.
	PjClassForTranspilationTest selectorsDo: [: selector |
		self deny: self jsCode includes: selector]

]

{ #category : #testing }
PjClassExtensionTranspilationTest >> testJavascriptInitialize [
	self assertClassMethod: #javascriptInitialize equals: '(){return this}'.
	self assert: self jsCode includes: PjClassForTranspilationTest name, '.', PjTranspiler pharoJsSelectorPrefix, 'javascriptInitialize()'.

]
