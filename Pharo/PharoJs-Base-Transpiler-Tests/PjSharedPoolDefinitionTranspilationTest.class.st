Class {
	#name : #PjSharedPoolDefinitionTranspilationTest,
	#superclass : #PjSingleClassTranspilationTest,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #accessing }
PjSharedPoolDefinitionTranspilationTest >> classToTranspile [
	^ PjSharedPoolForTest
]

{ #category : #accessing }
PjSharedPoolDefinitionTranspilationTest >> expectedClassName [
	^ self classToTranspile name
]

{ #category : #tests }
PjSharedPoolDefinitionTranspilationTest >> expectedFullClassDefinition [

	| superclassName |
	superclassName := self classToTranspile superclass
		                  nameToUseForJsConversion.
	^ 'Smalltalk.installClass(class {1} extends {2}\{
constructor()\{super();if(!{2}._sendsInitialize())\{this._initialize();\}\}
static _sendsInitialize()\{return true\}
static _initialize()\{{1}.cp$.A="sharedA";{1}.cp$.B="sharedB";{1}.cp$.C="sharedC";return this\}
static cp$=\{"C":null,"X":null,"A":null,"B":null\}\},\{\},\{\});{1}._initialize();
' format: {
			  className.
			  superclassName }
]

{ #category : #tests }
PjSharedPoolDefinitionTranspilationTest >> testClassVariables [

	
	self
		assert: self jsCode
		includes: self expectedFullClassDefinition 
]
