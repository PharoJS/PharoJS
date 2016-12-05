Class {
	#name : #PjWorkspaceBridgeVariable,
	#superclass : #LiteralVariable,
	#instVars : [
		'playground'
	],
	#category : #'PharoJsTools-Playground'
}

{ #category : #'code generation' }
PjWorkspaceBridgeVariable >> emitValue: methodBuilder [

	methodBuilder pushLiteralVariable: self.
]

{ #category : #accessing }
PjWorkspaceBridgeVariable >> playground [
	^ playground
]

{ #category : #accessing }
PjWorkspaceBridgeVariable >> playground: aPjPlayground [
	playground := aPjPlayground
]

{ #category : #accessing }
PjWorkspaceBridgeVariable >> value: anObject [
	| result |
	result := super value: anObject.
	(anObject isMemberOf: PjBridge) ifFalse: [
		playground bridge: nil.
		^ result ].
	playground bridge: anObject.
	^ result
]

{ #category : #'meta-object-protocol' }
PjWorkspaceBridgeVariable >> write: anObject [
	self value: anObject.
	^ anObject
]
