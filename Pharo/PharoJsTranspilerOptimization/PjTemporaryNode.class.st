"
I am a special version of RBTemporaryNode used in optimizations.

Note: I'm in the RB AST heirarchy, not the PjJavascript AST heirarchy
"
Class {
	#name : #PjTemporaryNode,
	#superclass : #RBTemporaryNode,
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
