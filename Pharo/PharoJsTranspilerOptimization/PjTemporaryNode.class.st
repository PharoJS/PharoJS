"
I am a special version of RBTemporaryNode used in optimizations.

Note: I'm in the RB AST heirarchy, not the PjJavascript AST heirarchy
"
Class {
	#name : #PjTemporaryNode,
	#superclass : #RBVariableNode,
	#instVars : [
		'test',
		'body'
	],
	#category : #'PharoJsTranspilerOptimization-AST'
}

{ #category : #testing }
PjTemporaryNode >> isOptimizableAsContionalBlock [
	^ true
]

{ #category : #initialization }
PjTemporaryNode >> named: aName start: aPosition [
	super named: aName start: aPosition.
	variable := TemporaryVariable named: aName.
]
