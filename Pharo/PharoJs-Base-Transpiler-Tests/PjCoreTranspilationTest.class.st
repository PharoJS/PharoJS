Class {
	#name : 'PjCoreTranspilationTest',
	#superclass : 'PjSingleClassTranspilationTest',
	#category : 'PharoJs-Base-Transpiler-Tests-Tests',
	#package : 'PharoJs-Base-Transpiler-Tests',
	#tag : 'Tests'
}

{ #category : 'accessing' }
PjCoreTranspilationTest >> classToTranspile [
	^ self transpilerClass coreClass
]

{ #category : 'tests' }
PjCoreTranspilationTest >> testClassSideMethods [

	self
		assertClassMethod: #require:
		equals: '(moduleName){return require(moduleName);}'
]

{ #category : 'tests' }
PjCoreTranspilationTest >> testInstanceSideMethods [
	self assert: self classToTranspile methodDict size equals: 0
]

{ #category : 'tests' }
PjCoreTranspilationTest >> testOptimizedJsAt [
	| method asNil |
	asNil := PjStringGenerator nilTestFunctionName.
	method := self classMethod: #handleDNU:for:.
	self assert: (method indexOfSubCollection: 'selector=((', asNil,'(aMessage)._selector()).split(":"))[0]') > 0.

]

{ #category : 'tests' }
PjCoreTranspilationTest >> testOptimizedMessagesWithJsMarker [

	| method asNil |
	asNil := PjStringGenerator nilTestFunctionName.
	method := self classMethod: #makePharoJsSelector:.
	self assert:
		(method indexOfSubCollection: '(selector.split("_")).join("_$")') > 0.
	self assert: (method indexOfSubCollection: 'pjSelector.push(') > 0.
	self assert: (method indexOfSubCollection: 'selector.charCodeAt(', asNil, '(idx)._45_(1)))') > 0.

]
