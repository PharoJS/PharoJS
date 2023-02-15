Class {
	#name : #PjCoreTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #accessing }
PjCoreTranspilationTest >> classToTranspile [
	^ self transpilerClass coreClass
]

{ #category : #tests }
PjCoreTranspilationTest >> testClassSideMethods [

	self
		assertClassMethod: #require:
		equals: '(moduleName){return require(moduleName);}'
]

{ #category : #tests }
PjCoreTranspilationTest >> testInstanceSideMethods [
	self assert: self classToTranspile methodDict size equals: 0
]

{ #category : #tests }
PjCoreTranspilationTest >> testOptimizedJsAt [
	| method asNil |
	asNil := PjStringGenerator nilTestFunctionName.
	method := self classMethod: #makePharoJsSelector:.
	self assert: (method indexOfSubCollection: asNil,'(aSelector[0])._61_(') > 0.
	self assert: (method indexOfSubCollection: asNil ,'(this.selectorCache.hasOwnProperty(aSelector))._ifTrue_(') > 0.
]
