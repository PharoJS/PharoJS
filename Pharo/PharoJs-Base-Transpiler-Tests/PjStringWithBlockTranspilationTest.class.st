Class {
	#name : #PjStringWithBlockTranspilationTest,
	#superclass : #PjGeneratedClassTranspilationTest,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #tests }
PjStringWithBlockTranspilationTest >> testBlock0Arg [
	self 
		assertStCode: '[123]' 
		convertedIncludes: 'function(){return 123}'.
]

{ #category : #tests }
PjStringWithBlockTranspilationTest >> testBlock0ArgWithReturn [
	self 
		assertStCode: '[^123]' 
		convertedIncludes: 'function(){throw $_err_$=123}'
]

{ #category : #tests }
PjStringWithBlockTranspilationTest >> testBlock1Arg [
	self 
		assertStCode: '[ :x | 123]' 
		convertedIncludes: 'function(x){return 123}'
]

{ #category : #tests }
PjStringWithBlockTranspilationTest >> testBlockAsArgument [
	self 
		assertStCode: '1 to: 10 by: 2 do: [: x | x ]' 
		convertedIncludes: '(1)._to_by_do_(10,2,function(x){return x})'
]

{ #category : #tests }
PjStringWithBlockTranspilationTest >> testEmptyBlock [
	self 
		assertStCode: '[]' 
		convertedIncludes: 'function(){return ', self nilInJavascript, '}'.
]
