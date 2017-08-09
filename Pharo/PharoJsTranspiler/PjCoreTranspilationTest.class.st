Class {
	#name : #PjCoreTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #accessing }
PjCoreTranspilationTest >> classToTranspile [
	^ self transpilerClass coreClass
]

{ #category : #testing }
PjCoreTranspilationTest >> testClassSideMethods [
	self assertClassMethod: #at:put: equals: '(jsName,anObject){return global[jsName]=anObject}'.
]

{ #category : #testing }
PjCoreTranspilationTest >> testInstanceSideMethods [
	self assert: self classToTranspile methodDict size equals: 0
]

{ #category : #testing }
PjCoreTranspilationTest >> testOptimizedJsAt [
	| method asNil |
	asNil := PjStringGenerator nilTestFunctionName.
	method := self classMethod: #makeJavascriptSelector:.
	self assert: (method indexOfSubCollection: asNil,'(',asNil,'(aSelector[0])._61_(')>0.
	self assert: (method indexOfSubCollection: asNil ,'(this.selectorCache.hasOwnProperty(aSelector))._ifTrue_(')>0.

]
