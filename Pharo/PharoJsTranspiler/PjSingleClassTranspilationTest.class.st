Class {
	#name : #PjSingleClassTranspilationTest,
	#superclass : #PjTranspilationClassCompilationTest,
	#instVars : [
		'className'
	],
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #accessing }
PjSingleClassTranspilationTest >> classToTranspile [
	^ PjClassForTranspilationTest
]

{ #category : #running }
PjSingleClassTranspilationTest >> expectedClassName [
	^'JsClass'
]

{ #category : #running }
PjSingleClassTranspilationTest >> setUp [
	super setUp.
	transpiler poolFor: self classToTranspile.
	transpiler pharoJsSelectorPrefix: self selectorsPrefix.
	self jsCode: (self convertClass: self classToTranspile).
	className := self expectedClassName
]

{ #category : #testing }
PjSingleClassTranspilationTest >> testBlockReferencingSelf [
	self assertInstanceMethod: #blocksReferencingSelf equals: '(){var ',PjStringGenerator selfName,'=this;(function(){return ',PjStringGenerator selfName,'});return this}'
]

{ #category : #testing }
PjSingleClassTranspilationTest >> testCascade [
	| prefix |
	prefix := self selectorsPrefix.
	self assertInstanceMethod: #cascadeSelf equals: '(){return (this.', prefix, 'm1(),this.', prefix, 'm_(4),this.', prefix, 'yourself())}'.
	self assertInstanceMethod: #cascadeSuper equals: '(){return (',self classToTranspile superclass name,'.prototype.', prefix, 'isNil.call(this),',self classToTranspile superclass name,'.prototype.', prefix, 'yourself.call(this))}'.
	self assertInstanceMethod: #cascade: equals: '(x){var $1;return ($1=$asNil$($asNil$(x).', prefix, 'foo()),$1.', prefix, 'bar(),$1.', prefix, 'yourself())}'.
	self assertInstanceMethod: #cascadeNested equals: '(){return (this.', prefix, 'm1(),this.', prefix, 'm_((this.', prefix, 'm1(),this.', prefix, 'm2())),this.', prefix, 'yourself())}'.

]

{ #category : #testing }
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

{ #category : #testing }
PjSingleClassTranspilationTest >> testClassSideMethods [
	| superclassName sharedPoolName |
	sharedPoolName := transpiler poolReference: PjSharedPoolForTest for: self classToTranspile.
	superclassName := transpiler poolReference: PjSuperClassForTranspilationTest for: self classToTranspile.
	self assertClassMethod: #c1 equals: '(){return this}'.
	self assertClassMethod: #c2 equals: '(){return this}'.
	self assertClassMethod: #initialize equals: '(){cp$.A="testA";return this}'.
	self assertClassMethod: #m1 equals: '(){',
		'cp$.X=cp$.$prototype;',
		superclassName,'.S=',superclassName,'.S;',
		sharedPoolName,'.C=',sharedPoolName,'.C;',
		'return this}'.
	self assert: (self jsCode endsWith: className, '.', self selectorsPrefix, 'initialize();').
	self assertClassMethod: #javascriptName equals: nil.
	self assertClassMethod: #methodWithJsGenerator equals: '(){', (self classToTranspile classMethod_jsGenerator: transpiler),'}'

]

{ #category : #testing }
PjSingleClassTranspilationTest >> testCompose [
	| prefix |
	prefix := self selectorsPrefix.
	self assertInstanceMethod: #composedCalls equals: '(){return $asNil$($asNil$(this.', prefix, 'm1()).', prefix, 'm_(4)).', prefix, 'm2()}'.

]

{ #category : #testing }
PjSingleClassTranspilationTest >> testInstanceSideMethods [
	| superclassName sharedPoolName |
	sharedPoolName := transpiler poolReference: PjSharedPoolForTest for: self classToTranspile.
	superclassName := transpiler poolReference: PjSuperClassForTranspilationTest for: self classToTranspile.
	self assertInstanceMethod: #m1 equals: '(){',
		'cp$.X=cp$.$prototype;',
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

{ #category : #testing }
PjSingleClassTranspilationTest >> testNative [
	| method |
	method := self instanceMethod: #native.
	self assert: method includes: 'x=x[4]'.
	self assert: method includes: 'x=x.foo'.
	self assert: method includes: 'x=x["a.b"]'.
	self assert: method includes: 'x[4]=42'.
	self assert: method includes: 'x.m(17)'.

]

{ #category : #testing }
PjSingleClassTranspilationTest >> testToDoExpr [
	self assertInstanceMethod: #toDoWithObjectAsParameter equals: '(){(1).', self selectorsPrefix, 'to_do_(10,Object);return this}'
]
