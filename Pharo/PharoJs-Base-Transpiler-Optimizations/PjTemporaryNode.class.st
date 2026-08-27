"
I am a special version of RBTemporaryNode used in optimizations.

Note: I'm in the RB AST heirarchy, not the PjJavascript AST heirarchy
"
Class {
	#name : 'PjTemporaryNode',
	#superclass : 'OCVariableNode',
	#category : 'PharoJs-Base-Transpiler-Optimizations-AST',
	#package : 'PharoJs-Base-Transpiler-Optimizations',
	#tag : 'AST'
}

{ #category : 'testing' }
PjTemporaryNode >> isOptimizableAsContionalBlock [
	^ true
]

{ #category : 'initialization' }
PjTemporaryNode >> named: aName start: aPosition [
	super named: aName start: aPosition.
	variable := TemporaryVariable named: aName.
]
