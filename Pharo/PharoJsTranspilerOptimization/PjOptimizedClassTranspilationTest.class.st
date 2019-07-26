Class {
	#name : #PjOptimizedClassTranspilationTest,
	#superclass : #PjTranspilationClassCompilationTest,
	#category : #'PharoJsTranspilerOptimization-Tests'
}

{ #category : #running }
PjOptimizedClassTranspilationTest >> setUp [
	super setUp.
	transpiler addAllOptionalConversions
]

{ #category : #testing }
PjOptimizedClassTranspilationTest >> testBlocksAndReturns [
	|prefix|
	prefix := PjTranspiler pharoJsSelectorPrefix.
	self jsCode: (self convertClass: PjClassForTranspilationTest).
	self assertInstanceMethod: #whileNotAtEnd
		equals: '(){this.', prefix, 'm_(function(x){while(true==$asNil$(x).', prefix, 'm1()){}});while(true==this.', prefix, 'm2()){}return 42}'.
	self assertInstanceMethod: #whileAtEnd
		equals: '(){this.', prefix, 'm_(function(x){while(true==$asNil$(x).', prefix, 'm1()){}});while(true==this.', prefix, 'm2()){}return this}'.

]

{ #category : #testing }
PjOptimizedClassTranspilationTest >> testSubIf [
	self jsCode: (self convertClass: PjClassForTranspilationTest).
	self assertClassMethod: #setupMessage equals: '(){return $asNil$((this===JsClass?"":"Sorry, ")).', PjTranspiler pharoJsSelectorPrefix, '44_("Click anywhere")}'.
	self assertClassMethod: #click: equals: '(ev){var m;var $_err_$={};try{m=($1=this.', PjTranspiler pharoJsSelectorPrefix, 'setupMessage())==undefined?',PjCore throwFunctionName,'($_err_$=this):$1;return m}catch(e){if(e===$_err_$)return e;throw e}}'.

]
