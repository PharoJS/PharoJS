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
	| sharedPoolVarsHolder superVarsHolder |
	sharedPoolVarsHolder := '$', PjSharedPoolForTest nameToUseForJsConversion.
	superVarsHolder := '$', PjSuperClassForTranspilationTest nameToUseForJsConversion.
	self assert: self jsCode includes: className, '.$$def('.
	self assert: self jsCode includes: 'cp$.X=cp$.'.
	self deny: self jsCode includes: '$$.X'.
	self deny: self jsCode includes: 'S=null'.
	self deny: self jsCode includes: '.document='.
	self assert: self jsCode includes: sharedPoolVarsHolder,'.C'.
	self assert: self jsCode includes: superVarsHolder,'.B'.
	self assert: self jsCode includes: superVarsHolder,'.S'.
	self deny: self jsCode includes: 'cp$.S'.
	self assert: self jsCode includes: '=cp$.A'.
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
		className, '.cp$.X='className, '.cp$.$prototype;',
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
	self assert: self jsCode includes: 'Smalltalk.installAllAliases({'.
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
