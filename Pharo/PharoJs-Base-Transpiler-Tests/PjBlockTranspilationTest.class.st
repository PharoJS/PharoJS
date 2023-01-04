Class {
	#name : #PjBlockTranspilationTest,
	#superclass : #PjTranspilationTest,
	#instVars : [
		'instVar'
	],
	#classVars : [
		'SomeClassVar'
	],
	#pools : [
		'PjDomGlobals',
		'PjUniversalGlobals'
	],
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #'class initialization' }
PjBlockTranspilationTest class >> initialize [
	SomeClassVar := 'SomeClassVariable'
]

{ #category : #private }
PjBlockTranspilationTest >> closedBlock: x [
	| y |
	y := 23.
	^  [:v| |w| {v.w.x.y.instVar.123}] asClosedBlock
]

{ #category : #private }
PjBlockTranspilationTest >> openBlock: x [
	| y |
	y := 23.
	^  [:v| |w| {v.w.x.y.instVar.123}]
]

{ #category : #tests }
PjBlockTranspilationTest >> testBlock1Arg [
	self 
		assertStBlock: [ :x | 123]
		convertsTo: '((x)=>{return 123})'
]

{ #category : #tests }
PjBlockTranspilationTest >> testBlock1ArgWithReturn [
	self 
		assertStBlock: [ :x | ^123]
		convertsTo: '(function(x){throw $_err_$=123})'
]

{ #category : #tests }
PjBlockTranspilationTest >> testBlock2Args [
	self 
		assertStBlock: [ : x : y | {x. y}]
		convertsTo: '(function(x,y){return [x,y]})'
]

{ #category : #tests }
PjBlockTranspilationTest >> testBlock2ArgsWithReturn [
	self 
		assertStBlock: [ : x : y | ^{x. y}]
		convertsTo: '(function(x,y){throw $_err_$=[x,y]})'
]

{ #category : #tests }
PjBlockTranspilationTest >> testBlockEmpty [
	self 
		assertStBlock: []
		convertsTo: '(function(){return ', self nilInJavascript, '})'
]

{ #category : #tests }
PjBlockTranspilationTest >> testBlockWithExternalVariables [
	| x |
	self 
		assertStBlock: [ :y | |z| z:= y. {y. z. 123}]
		convertsTo: '(function(y){var z;z=y;return [y,z,123]})'.
	self 
		assertStBlock: [ document ]
		convertsTo: '(function(){return document})'.
	x := nil.
	self
		assertStBlock: [ x ] asClosedBlock
		convertsTo: '(function(x){return function(){return x}})(null)'.
	x := 'string'.
	self
		assertStBlock: [ x ] asClosedBlock
		convertsTo: '(function(x){return function(){return x}})("string")'.
	x := #(1 (2 3) 4).
	self
		assertStBlock: [ x ] asClosedBlock
		convertsTo: '(function(x){return function(){return x}})([1,[2,3],4])'.
	x := {#x->1. #y->2} asDictionary.
	self
		assertStBlock: [ x ] asClosedBlock
		convertsTo: '(function(x){return function(){return x}})({"x":1,"y":2})'.
	x := 1337.
	self
		assertStBlock: [ x ] asClosedBlock
		convertsTo: '(function(x){return function(){return x}})(1337)'.
	self
		assertStBlock: [ {x.self js_this} ] asClosedBlock
		convertsTo: '(function(x){return function(){return [x,this]}})(1337)'.
	self
		should: [transpiler convertToJs: [ Smalltalk ]] raise: PjJavascriptTranspilationError.
	self
		should: [transpiler convertToJs: [ x ]] raise: PjJavascriptTranspilationError.
	self
		should: [transpiler convertToJs: [ testSelector ]] raise: PjJavascriptTranspilationError.
	self
		should: [transpiler convertToJs: [ SomeClassVar ]] raise: PjJavascriptTranspilationError.
	self
		should: [transpiler convertToJs: [ self testBlockWithExternalVariables ]] raise: PjJavascriptTranspilationError.
	self
		should: [transpiler convertToJs: [ super testBlockWithExternalVariables ]] raise: PjJavascriptTranspilationError.
	{ Object new. { 1->2} asDictionary. { #x->Object new} asDictionary. { Object new} } do: [ :y|
		self
			should: [transpiler convertToJs: [ y ]] raise: PjJavascriptTranspilationError
	].
	self 
		assertStBlock: ([ : x1 | [ x1 ]] value: 42) asClosedBlock
		convertsTo: '(function(x1){return function(){return x1}})(42)'.
]

{ #category : #tests }
PjBlockTranspilationTest >> testBlockWithNestedScopes [
	|openBlock closedBlock x a|
	x := 1337.
	instVar := 1066.
	a := 42.
	openBlock := [: y |  [:v| |w| {a.v.w.x.y.instVar.123}] ] value: 91.
	closedBlock := [: q |  [:v| |w| {a.v.w.x.q.instVar.321}] asClosedBlock ] value: 73.
	a := 107.
	instVar := 1492.
	self 
		assertStBlock: [|z| z:= self js_this. [|w| w := z.{z. w. self js_this. 123}]]
		convertsTo: '(function(){var z;z=this;return function(){var w;w=z;return [z,w,this,123]}})'.
	self 
		assertStBlock: [|z| z:= self js_this. [: v| |w|{v.w.x.z.instVar.123}]] asClosedBlock
		convertsTo: '(function(x,instVar){return function(){var z;z=this;return function(v){var w;return [v,w,x,z,instVar,123]}}})(1337,1492)'.
	self 
		assertStBlock: closedBlock
		convertsTo: '(function(a,x,q,instVar){return function(v){var w;return [a,v,w,x,q,instVar,321]}})(42,1337,73,1066)'. 
	self 
		assertStBlock: openBlock asClosedBlock
		convertsTo: '(function(a,x,y,instVar){return function(v){var w;return [a,v,w,x,y,instVar,123]}})(107,1337,91,1492)'.
	self 
		assertStBlock: (self closedBlock: 17)
convertsTo: '(function(x,y,instVar){return function(v){var w;return [v,w,x,y,instVar,123]}})(17,23,1492)'.
	self 
		assertStBlock: (self openBlock: 42) asClosedBlock
		convertsTo: '(function(x,y,instVar){return function(v){var w;return [v,w,x,y,instVar,123]}})(42,23,1492)'.
]

{ #category : #tests }
PjBlockTranspilationTest >> testBlockWithNestedScopesToFix [
	<expectedFailure>
	self 
		assertStBlock: ([ :y| [ |w| w:=17. [ { w.y.2} ] ] ] value: 4) value asClosedBlock
		convertsTo: '(function(w,y){return function(){return [w,y,2]}})(17,4)'.
	self 
		assertStBlock: ([ :y| [ |w| w:=17. [ { w.y.2} ] ] ] value: 4) value
		convertsTo: '(function(w,y){return function(){return [w,y,2]}})(17,4)'.
]

{ #category : #tests }
PjBlockTranspilationTest >> testBlockWithReferencedScopes [
	| x y superClosed |
	y := 17.
	superClosed := [ y ] asClosedBlock.
	x := 1337.
	self 
		assertStBlock: [|w| w := superClosed value.{w.x. 123}] asClosedBlock
		convertsTo: '(function(superClosed,x){return function(){var w;w=$asNil$(superClosed)._value();return [w,x,123]}})((function(y){return function(){return y}})(17),1337)'.
]

{ #category : #tests }
PjBlockTranspilationTest >> testValuedBlock [
	self 
		assertStBlock: [23] asValuedBlock
		convertsTo: '(function(){return 23})()'.
	self 
		assertStBlock: ([: a : b | ] asValuedBlockWithArgs: { 23. self class })
		convertsTo: '(function(a,b){return null})(23,',self className,')'.
]
