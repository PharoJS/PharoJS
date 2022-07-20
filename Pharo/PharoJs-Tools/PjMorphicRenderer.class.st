Class {
	#name : #PjMorphicRenderer,
	#superclass : #GLMMorphicPharoScriptRenderer,
	#instVars : [
		'playground'
	],
	#category : #'PharoJs-Tools-Playground'
}

{ #category : #accessing }
PjMorphicRenderer >> makeVariable: aString [
	aString = #bridge ifTrue: [ ^ playground bridgeVar ].
	(playground allJavascriptGlobals includes: aString) ifFalse: [
		^ WorkspaceVariable key: aString value: nil
	].
	Error signal: 'unexpected makeVariable for: ',aString.
	^ PjWorkspaceGlobalVariable key: aString value: playground bridge
]

{ #category : #rendering }
PjMorphicRenderer >> modelFor: aPresentation [
	playground := aPresentation playground.
	^ PjRubricSmalltalkTextModel new
		glamourPresentation: aPresentation;
		highlightSmalltalk: true;
		highlightSmalltalkContext: aPresentation highlightSmalltalkContext;
		bindingsStrategy: self workspaceBindingsStrategy;
		yourself
]

{ #category : #setup }
PjMorphicRenderer >> workspaceBind: aString toBindings: currentBindings [
	(currentBindings includesKey: aString) ifFalse: [
		currentBindings add: (self makeVariable: aString asSymbol)].
	^ currentBindings associationAt: aString
]

{ #category : #setup }
PjMorphicRenderer >> workspaceBindingsStrategy [
	^ [ :currentBindings :aString :aTextModel | 
	(aTextModel doItReceiver class allInstVarNames includes: aString)
		ifTrue: [ nil ]
		ifFalse: [ self workspaceBind: aString toBindings: currentBindings ] ]
]
