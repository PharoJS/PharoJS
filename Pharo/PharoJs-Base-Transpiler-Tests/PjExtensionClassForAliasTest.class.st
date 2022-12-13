Class {
	#name : #PjExtensionClassForAliasTest,
	#superclass : #Object,
	#category : #'PharoJs-Base-Transpiler-Tests-Support'
}

{ #category : #aliasing }
PjExtensionClassForAliasTest class >> classM1 [

	<jsAlias: #classM1alias>
	^ #classM1
]

{ #category : #aliasing }
PjExtensionClassForAliasTest class >> classM2 [

	<jsAlias: #classM2alias1 with: #classM2alias2>
	^ #classM2
]

{ #category : #transpiling }
PjExtensionClassForAliasTest class >> isClassExtension [

	<pharoJsSkip>
	^ true
]

{ #category : #transpiling }
PjExtensionClassForAliasTest class >> javascriptName [ 

	<pharoJsSkip>
	^ #Object
]

{ #category : #aliasing }
PjExtensionClassForAliasTest >> m1 [

	<jsAlias: #m1alias>
	^ #instanceM1
]

{ #category : #aliasing }
PjExtensionClassForAliasTest >> m2 [

	<jsAlias: #m2alias1 with: #m2alias2 with: #m2alias3>
	^ #instanceM2
]
