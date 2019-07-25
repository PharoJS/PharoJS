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
	self jsCode: (self convertClass: self classToTranspile).
	className := self expectedClassName
]

{ #category : #testing }
PjSingleClassTranspilationTest >> testBlockReferencingSelf [
	self assertInstanceMethod: #blocksReferencingSelf equals: '(){var ',PjStringGenerator selfName,'=this;(function(){return ',PjStringGenerator selfName,'});return this}'
]

{ #category : #testing }
PjSingleClassTranspilationTest >> testCascade [
	self assertInstanceMethod: #cascadeSelf equals: '(){return (this.pj_m1(),this.pj_m_(4),this.pj_yourself())}'.
	self assertInstanceMethod: #cascadeSuper equals: '(){return (',self classToTranspile superclass name,'.prototype.pj_isNil.call(this),',self classToTranspile superclass name,'.prototype.pj_yourself.call(this))}'.
	self assertInstanceMethod: #cascade: equals: '(x){var $1;return ($1=$asNil$($asNil$(x).pj_foo()),$1.pj_bar(),$1.pj_yourself())}'.
	self assertInstanceMethod: #cascadeNested equals: '(){return (this.pj_m1(),this.pj_m_((this.pj_m1(),this.pj_m2())),this.pj_yourself())}'.

]

{ #category : #testing }
PjSingleClassTranspilationTest >> testClassAndPoolVariableDefinition [
	| classVarsHolder instanceSideClassVarsHolder poolVarsHolder |
	instanceSideClassVarsHolder := className, '.prototype.', self classVariablesHolderName.
	classVarsHolder := className, '.', self classVariablesHolderName.
	poolVarsHolder := PjSharedPoolForTest nameToUseForJsConversion, '.', self classVariablesHolderName.
	self assert: self jsCode includes: '(',classVarsHolder, ')'.
	self assert: self jsCode includes: '$$.X_=function($0){return $$.X=$0};'.
	self deny: self jsCode includes: '$$.X$=function('.
	self assert: self jsCode includes: '$$.Y_=function($0){return $$.Y=$0}'.
	self assert: self jsCode includes: '$$.$prototype_=function($0){return $$.$prototype=$0}'.
	self assert: self jsCode includes: '$$.A_=function($0){return $$.A=$0}'.
	self deny: self jsCode includes: '$$.A$=function('.
	self deny: self jsCode includes: '$$.B_='.
	self deny: self jsCode includes: '$$.document_='.
	self assert: self jsCode includes: '$$.C_=',poolVarsHolder,'.C_'.
	self assert: self jsCode includes: '$$.C$=',poolVarsHolder,'.C$'.

]

{ #category : #testing }
PjSingleClassTranspilationTest >> testClassSideMethods [
	self assertClassMethod: #c1 equals: '(){return this}'.
	self assertClassMethod: #c2 equals: '(){return this}'.
	self assertClassMethod: #initialize equals: '(){return this}'.
	self assertClassMethod: #m1 equals: '(){',
		'this.',self classVariablesHolderName,'.X=this.',self classVariablesHolderName,'.$prototype;',
		'this.',self classVariablesHolderName,'.S_(this.',self classVariablesHolderName,'.S);',
		'this.',self classVariablesHolderName,'.C_(this.',self classVariablesHolderName,'.C$());',
		'return this}'.
	self assert: (self jsCode endsWith: className, '._initialize();').
	self assertClassMethod: #javascriptName equals: nil.
	self assertClassMethod: #methodWithJsGenerator equals: '(){', self classToTranspile classMethodJsGenerator,'}'

]

{ #category : #testing }
PjSingleClassTranspilationTest >> testCompose [
	self assertInstanceMethod: #composedCalls equals: '(){return $asNil$($asNil$(this.pj_m1()).pj_m_(4)).pj_m2()}'.

]

{ #category : #testing }
PjSingleClassTranspilationTest >> testInstanceSideMethods [
	self assertInstanceMethod: #m1 equals: '(){',
		'this.X_(this.$prototype);',
		'this.S_(this.S);',
		'this.C_(this.C$());',
		'return this}'.
	self assertInstanceMethod: #m2 equals: '(){return this}'.
	self assertInstanceMethod: #@ equals: '(op){return this}'.
	self assertInstanceMethod: #add:and: equals: '(op1,op2){return op2}'.
	self deny: self jsCode includes: 'methodToSkip'.
	self deny: self jsCode includes: 'ThisShouldBeSkipped'.
	self assertInstanceMethod: #m: equals: '($in){console.log("abc")}'.
	self assertInstanceMethod: #insanceMethodWithJsGenerator equals:  '(){', self classToTranspile instanceMethodJsGenerator, '}'.

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
	self assertInstanceMethod: #toDoWithObjectAsParameter equals: '(){(1).pj_to_do_(10,Object);return this}'
]
