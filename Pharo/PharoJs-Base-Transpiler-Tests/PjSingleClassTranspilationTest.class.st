Class {
	#name : #PjSingleClassTranspilationTest,
	#superclass : #PjTranspilationClassCompilationTest,
	#instVars : [
		'className'
	],
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #accessing }
PjSingleClassTranspilationTest >> classToTranspile [
	^ PjClassForTranspilationTest
]

{ #category : #accessing }
PjSingleClassTranspilationTest >> expectedClassName [
	^classToTranspile nameToUseForJsConversion
]

{ #category : #running }
PjSingleClassTranspilationTest >> setUp [
	super setUp.
	transpiler poolFor: self classToTranspile.
	transpiler pharoJsSelectorPrefix: self selectorsPrefix.
	self jsCode: (self convertClass: self classToTranspile).
	className := self expectedClassName
]

{ #category : #tests }
PjSingleClassTranspilationTest >> testBlockReferencingSelf [
	self assertInstanceMethod: #blocksReferencingSelf equals: '(){var ',PjStringGenerator selfName,'=this;(()=>{return ',PjStringGenerator selfName,'});return this}'
]

{ #category : #tests }
PjSingleClassTranspilationTest >> testCascade [
	self assertInstanceMethod: #cascadeSelf equals: '(){return (this._m1(),this._m_(4),this._yourself())}'.
	self assertInstanceMethod: #cascadeSuper equals: '(){return (super._isNil(),super._yourself())}'.
	self assertInstanceMethod: #cascade: equals: '(x){var $1;return ($1=$asNil$($asNil$(x)._foo()),$1._bar(),$1._yourself())}'.
	self assertInstanceMethod: #cascadeNested equals: '(){return (this._m1(),this._m_((this._m1(),this._m2())),this._yourself())}'.
]

{ #category : #tests }
PjSingleClassTranspilationTest >> testClassAndPoolVariableDefinition [

	| sharedPoolVarsHolder superVarsHolder classVarHolder |
	sharedPoolVarsHolder := PjSharedPoolForTest nameToUseForJsConversion
	                        , '.cp$'.
	superVarsHolder := PjSuperClassForTranspilationTest
		                   nameToUseForJsConversion , '.cp$'.
	classVarHolder := self expectedClassName, '.cp$'. 
	self assert: self jsCode includes: '"A":null'.
	self assert: self jsCode includes: classVarHolder , '.A'.
	self deny: self jsCode includes: sharedPoolVarsHolder , '.A'.
	self assert: self jsCode includes: '"X":null'.
	self assert: self jsCode includes: classVarHolder , '.X'.
	self deny: self jsCode includes: sharedPoolVarsHolder , '.X'.
	self deny: self jsCode includes: '"B":null'.
	self assert: self jsCode includes: superVarsHolder , '.B'.
	self deny: self jsCode includes: sharedPoolVarsHolder , '.B'.
	self deny: self jsCode includes: '"C":null'.
	self assert: self jsCode includes: sharedPoolVarsHolder , '.C'.

]

{ #category : #tests }
PjSingleClassTranspilationTest >> testClassSideMethods [
	| superclassName sharedPoolName |
	sharedPoolName := transpiler poolReference: PjSharedPoolForTest for: self classToTranspile.
	superclassName := transpiler poolReference: PjSuperClassForTranspilationTest for: self classToTranspile.
	self assertClassMethod: #c1 equals: '(){return this}'.
	self assertClassMethod: #c2 equals: '(){return this}'.
	self assertClassMethod: #initialize equals: '(){', className, '.cp$.A="testA";return this}'.
	self assertClassMethod: #m1 equals: '(){',
		className, '.cp$.X=', className, '.cp$.$prototype;',
		superclassName,'.S=',superclassName,'.S;',
		sharedPoolName,'.C=',sharedPoolName,'.C;',
		'return this}'.
	self assert: (self jsCode endsWith: className, '._initialize();').
	self assertClassMethod: #javascriptName equals: nil.
	self assertClassMethod: #methodWithJsGenerator equals: '(){', (self classToTranspile classMethod_jsGenerator: transpiler),'}'
]

{ #category : #tests }
PjSingleClassTranspilationTest >> testCompose [
	self assertInstanceMethod: #composedCalls equals: '(){return $asNil$($asNil$(this._m1())._m_(4))._m2()}'.
]

{ #category : #tests }
PjSingleClassTranspilationTest >> testInstanceSideMethods [
	| superclassName sharedPoolName |
	sharedPoolName := transpiler poolReference: PjSharedPoolForTest for: self classToTranspile.
	superclassName := transpiler poolReference: PjSuperClassForTranspilationTest for: self classToTranspile.
	self assertInstanceMethod: #m1 equals: '(){',
		className, '.cp$.X=', className, '.cp$.$prototype;',
		superclassName,'.S=',superclassName,'.S;',
		sharedPoolName,'.C=',sharedPoolName,'.C;',
		'return this}'.
	self assertInstanceMethod: #m2 equals: '(){return this}'.
	self assertInstanceMethod: #@ equals: '(op){return this}'.
	self assertInstanceMethod: #add:and: equals: '(op1,op2){return op2}'.
	self deny: self jsCode includes: 'methodToSkip'.
	self deny: self jsCode includes: 'ThisShouldBeSkipped'.
	self assertInstanceMethod: #m: equals: '($in){console.log("abc")}'.
	self assertInstanceMethod: #instanceMethodWithJsGenerator equals:  '(){', (self classToTranspile instanceMethod_jsGenerator: transpiler), '}'.
]

{ #category : #tests }
PjSingleClassTranspilationTest >> testMethodAlias [
	self assert: self jsCode includes: '"_alias":["myAlias"]'.
	self assert: self jsCode includes: '"_alias2":["andAlias2","myAlias2"]'.

]

{ #category : #tests }
PjSingleClassTranspilationTest >> testNative [
	| method |
	method := self instanceMethod: #native.
	self assert: method includes: 'x=x[4]'.
	self assert: method includes: 'x=x.foo'.
	self assert: method includes: 'x=x["a.b"]'.
	self assert: method includes: 'x[4]=42'.
	self assert: method includes: 'x.m(17)'.
]

{ #category : #tests }
PjSingleClassTranspilationTest >> testToDoExpr [
	self assertInstanceMethod: #toDoWithObjectAsParameter equals: '(){(1)._to_do_(10,Object);return this}'
]
