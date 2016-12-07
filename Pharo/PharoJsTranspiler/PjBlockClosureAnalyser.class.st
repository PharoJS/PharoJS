"
I am used to analyse BlockClosures.

To close a block closure, i make copies of all free variables in the context of the original block.
"
Class {
	#name : #PjBlockClosureAnalyser,
	#superclass : #Object,
	#instVars : [
		'externalVariables',
		'freeVariables',
		'blockForAnalysis'
	],
	#category : #'PharoJsTranspiler-Kernel'
}

{ #category : #'instance creation' }
PjBlockClosureAnalyser class >> onBlock: aBlockClosure [
	^self new blockForAnalysis: aBlockClosure
]

{ #category : #accessing }
PjBlockClosureAnalyser >> blockForAnalysis [
	^ blockForAnalysis
]

{ #category : #accessing }
PjBlockClosureAnalyser >> blockForAnalysis: anObject [
	blockForAnalysis := anObject
]

{ #category : #visiting }
PjBlockClosureAnalyser >> checkFree: aRBVariableNode [
	| name |
	name := aRBVariableNode name.
	self externalVariables at: name ifPresent: [ : value |
		(value isKindOf: Error) ifTrue: [ value signal ].
		value isLiteralJavascriptValue ifFalse: [ PjJavascriptTranspilationError signal: 'reference to non-literal value in variable: ',name ].
		self register: name with: value.
		^ PjTempVariableNode identifier: name
	].
	^ nil
]

{ #category : #visiting }
PjBlockClosureAnalyser >> closeAst: aPjJavascriptAstNode with: aPjAstConverter [
	freeVariables isEmpty
		ifTrue: [ ^ aPjJavascriptAstNode ].
	^ PjApplyNode
		func:
			(PjFunctionNode
				parameters: freeVariables keys
				locals: #()
				body: {(PjReturnNode expression: aPjJavascriptAstNode)})
		args:
			(freeVariables values
				collect:
					[ :each | each convertToJavascriptAstUsing: aPjAstConverter ])
]

{ #category : #public }
PjBlockClosureAnalyser >> externalVariables [
	^ externalVariables ifNil: [ externalVariables := blockForAnalysis externalVariables ]
]

{ #category : #'initialize-release' }
PjBlockClosureAnalyser >> initialize [
	freeVariables := OrderedDictionary new
]

{ #category : #accessing }
PjBlockClosureAnalyser >> isClosed [
	^self blockForAnalysis isClosed
]

{ #category : #'initialize-release' }
PjBlockClosureAnalyser >> register: aString with: anObject [
	freeVariables at: aString put: anObject
]

{ #category : #accessing }
PjBlockClosureAnalyser >> sourceNode [
	^self blockForAnalysis sourceNode.
]
