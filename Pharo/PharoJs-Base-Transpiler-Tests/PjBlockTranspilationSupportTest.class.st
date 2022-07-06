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

	| context actualTempValue variable allVariables scope |
	context := block originalBlock outerContext.
	scope := context sourceNode scope.
	allVariables := scope allTemps.
	valuesDict keysDo: [ :tempName | 
		variable := allVariables detect: [ : each | each name = tempName ].
		actualTempValue := variable valueStartAtContext: context.
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
	         { 
		         a.
		         v.
		         w.
		         x.
		         y.
		         instVar.
		         123 } ] ] value: (valuesDict at: #y).
	self assertBlock: block externalVarValues: valuesDict.
	self should: [(block externalVariablesDict at: #block) signal] raise: PjJavascriptTranspilationError 
]

{ #category : #tests }
PjBlockTranspilationSupportTest >> test1ArgClosedBlock3ExternalVarsLevel2 [

	| outerBlock x a valuesDict closedBlock |
	valuesDict := { 
		              (#x -> 1337).
		              (#a -> 42).
		              (#y -> 91) } asDictionary.
	x := valuesDict at: #x.
	instVar := 1066.
	a := valuesDict at: #a.
	outerBlock := [ :y | 
	              [ :v | 
	              | w |
	              { 
		              a.
		              v.
		              w.
		              x.
		              y.
		              instVar.
		              123 } ] asClosedBlock ].
	closedBlock := outerBlock value: (valuesDict at: #y).
	self assertBlock: closedBlock externalVarValues: valuesDict.
	self
		assert: (closedBlock externalVariablesDict at: #outerBlock)
		identicalTo: outerBlock.
	self
		assert: (closedBlock externalVariablesDict at: #closedBlock) isNil
]
