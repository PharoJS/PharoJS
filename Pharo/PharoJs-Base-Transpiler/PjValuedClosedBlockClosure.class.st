"
I represent a closed block closure that is valued upon JS code loading. I am useful for bridge interactions.
"
Class {
	#name : #PjValuedClosedBlockClosure,
	#superclass : #PjClosedBlockClosure,
	#type : #variable,
	#instVars : [
		'arguments'
	],
	#category : #'PharoJs-Base-Transpiler-Kernel'
}

{ #category : #'instance creation' }
PjValuedClosedBlockClosure class >> newFrom: aBlock [
	^self newFrom: aBlock withArgs: #()
]

{ #category : #'instance creation' }
PjValuedClosedBlockClosure class >> newFrom: aBlock withArgs: args [

	| newInstance |
	aBlock isClosed ifTrue: [ 
		PjJavascriptTranspilationError signal:
			'Cannot build a valued block from a closed one' ].
	newInstance := self
		               startpc: aBlock startpc
		               numArgs: aBlock numArgs
		               copiedValues: aBlock copiedValuesForClosedBlock
		               originalBlock: aBlock.
	^ newInstance
		  arguments: args;
		  yourself
]

{ #category : #accessing }
PjValuedClosedBlockClosure >> arguments [
	^ arguments
]

{ #category : #accessing }
PjValuedClosedBlockClosure >> arguments: anObject [
	arguments := anObject
]

{ #category : #converting }
PjValuedClosedBlockClosure >> convertToJsUsing: aPjTranspiler [ 
	aPjTranspiler convertValuedBlock: self
]
