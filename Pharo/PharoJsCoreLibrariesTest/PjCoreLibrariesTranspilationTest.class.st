Class {
	#name : #PjCoreLibrariesTranspilationTest,
	#superclass : #PjTranspilationClassCompilationTest,
	#category : #'PharoJsCoreLibrariesTest-Collections'
}

{ #category : #testing }
PjCoreLibrariesTranspilationTest >> testPjStringClass [
	self jsCode: (self convertClass: PjString).
	self assertInstanceMethod: #= equals: '(other){return this==other}'.
	self assertInstanceMethod: #, equals:  '(other){return this+other}'.
]

{ #category : #testing }
PjCoreLibrariesTranspilationTest >> testPjUndefinedObjectClass [
	self jsCode: (self convertClass: PjUndefinedObject).
	self assertInstanceMethod: #= equals:  '(other){return undefined==other}'.
	self assertClassMethod: #new equals: '(){return Smalltalk.', transpiler pharoJsSelectorPrefix, 'signal_("cannot create instances of UndefinedObject")}'.
	self assertClassMethod: #javascriptInitialize equals: '(){Smalltalk.', transpiler pharoJsSelectorPrefix, 'nilInJs_(this.', transpiler pharoJsSelectorPrefix, 'basicNew());return this}'
]
