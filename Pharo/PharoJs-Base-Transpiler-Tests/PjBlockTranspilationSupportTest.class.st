Class {
	#name : #PjBlockTranspilationSupportTest,
	#superclass : #TestCase,
	#instVars : [
		'instVar'
	],
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #tests }
PjBlockTranspilationSupportTest >> assertBlock: block externalVarValues: valuesDict [

	| context scope allTempNames actualTempValue allVariables variable currentScope currentContext|
	context := block outerContext.
	scope := context sourceNode scope.
	allTempNames := scope allTempNames.
	allVariables := scope allTemps.
	valuesDict keysDo: [ :tempName | 
		variable := allVariables detect: [ : each | each name = tempName ].
		currentScope := scope.
		currentContext := context.
		[ currentScope == variable scope ] whileFalse: [
			currentContext := currentContext outerContext.
			currentScope := currentContext sourceNode scope ].
		actualTempValue := currentContext at: variable index.
		self
			assert: actualTempValue
			equals: (valuesDict at: tempName) ]
]

{ #category : #tests }
PjBlockTranspilationSupportTest >> test0ArgBlock1ExtenalVarLevel1 [

	| block x valuesDict  |
	valuesDict := { #x -> 1337.} asDictionary.
	x := valuesDict at: #x.
	block := [ x + 1 ].
	self assertBlock: block externalVarValues: valuesDict 
]

{ #category : #tests }
PjBlockTranspilationSupportTest >> test0ArgBlock2ExternalVarsLevel1 [

	| block x a valuesDict |
	valuesDict := { 
		              (#x -> 1337).
		              (#a -> 42) } asDictionary.
	x := valuesDict at: #x.
	instVar := 1066.
	a := valuesDict at: #a.
	block := [ 
	         | w |
	         { 
		         a.
		         w.
		         x.
		         instVar.
		         123 } ].
	self assertBlock: block externalVarValues: valuesDict
]

{ #category : #tests }
PjBlockTranspilationSupportTest >> test1ArgBlock1ExternalVarLevel1 [
	
	| block x valuesDict  |
	valuesDict := { #x -> 1337.} asDictionary.
	x := valuesDict at: #x.
	block := [: a | x + 1 ].
	self assertBlock: block externalVarValues: valuesDict 
]

{ #category : #tests }
PjBlockTranspilationSupportTest >> test1ArgBlock2ExternalVarsLevel1 [

	| block x a valuesDict |
	valuesDict := { 
		              (#x -> 1337).
		              (#a -> 42) } asDictionary.
	x := valuesDict at: #x.
	instVar := 1066.
	a := valuesDict at: #a.
	block := [ :v | 
	         | w |
	         { 
		         a.
		         v.
		         w.
		         x.
		         instVar.
		         123 } ].
	self assertBlock: block externalVarValues: valuesDict
]

{ #category : #tests }
PjBlockTranspilationSupportTest >> test1ArgBlock3ExternalVarsLevel2 [

	| block x a valuesDict |
	valuesDict := { 
		              (#x -> 1337).
		              (#a -> 42).
		              (#y -> 91) } asDictionary.
	x := valuesDict at: #x.
	instVar := 1066.
	a := valuesDict at: #a.
	block := [ :y | 
	      			[ :v | 
						| w |
	         			{a. v. w. x. y. instVar. 123}] ] value: (valuesDict at: #y).
	self assertBlock: block externalVarValues: valuesDict
]
