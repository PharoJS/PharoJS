Class {
	#name : #PjCoverageTranspilerTest,
	#superclass : #TestCase,
	#instVars : [
		'factory'
	],
	#category : #'PharoJs-Benchmark-Coverage'
}

{ #category : #tests }
PjCoverageTranspilerTest >> setUp [
	super setUp.
	factory := ClassFactoryForTestCase new
]

{ #category : #tests }
PjCoverageTranspilerTest >> tearDown [ 
	factory cleanUp.
	super tearDown.

]

{ #category : #tests }
PjCoverageTranspilerTest >> testClassDeclrationTranspilationFailure [

	| result |
	result := self transpileClass: nil.
	self deny: result isSuccess.
	self assert: result isClassDeclarationFailed.
	self deny: result isMethodTranspilationFailed
]

{ #category : #tests }
PjCoverageTranspilerTest >> testTranspileClassWith1EmptyMethod [

	| class result |
	class := factory newClass.
	class compile: #m.
	result := self transpileClass: class.
	self assert: result isSuccess.
	self
		assertCollection: result successSelectors
		hasSameElements: #( m ).
	self deny: result isClassDeclarationFailed.
	self deny: result isMethodTranspilationFailed
]

{ #category : #tests }
PjCoverageTranspilerTest >> testTranspileClassWith1PrimitiveMethod [

	| class result |
	class := factory newClass.
	class
		compile: '== anObject
	<primitive: 110>
	self primitiveFailed';
		compile: #m1;
		compile: #m2.
	result := self transpileClass: class.
	self deny: result isSuccess.
	self deny: result isClassDeclarationFailed.
	self assert: result isMethodTranspilationFailed.
	self
		assertCollection: result successSelectors
		hasSameElements: #( m1 m2 ).
	self assertCollection: result failedSelectors hasSameElements: #( == )
]

{ #category : #tests }
PjCoverageTranspilerTest >> testTranspileClassWithMethodAccessingThisContext [

	| class result |
	class := factory newClass.
	class
		compile: 'currentContext
	^thisContext';
		compile: #m1;
		compile: #m2.
	result := self transpileClass: class.
	self deny: result isSuccess.
	self deny: result isClassDeclarationFailed.
	self assert: result isMethodTranspilationFailed.
	self
		assertCollection: result successSelectors
		hasSameElements: #( m1 m2 ).
	self assertCollection: result failedSelectors hasSameElements: #( currentContext )
]

{ #category : #tests }
PjCoverageTranspilerTest >> testTranspileEmptyClass [

	| result |
	result := self transpileClass: factory newClass.
	self assert: result isSuccess.
	self assert: result successSelectors isEmpty.
	self deny: result isClassDeclarationFailed.
	self deny: result isMethodTranspilationFailed
]

{ #category : #tests }
PjCoverageTranspilerTest >> transpileClass: aClass [

	^ PjCoverageTranspiler  new convertClass: aClass
]
