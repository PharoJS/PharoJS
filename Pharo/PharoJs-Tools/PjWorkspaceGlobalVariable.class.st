Class {
	#name : #PjWorkspaceGlobalVariable,
	#superclass : #LiteralVariable,
	#category : #'PharoJs-Tools-Playground'
}

{ #category : #accessing }
PjWorkspaceGlobalVariable >> bridge: aBridge [
	value := PjProxy proxyNamed: self key onBridge: aBridge oid: self key
]

{ #category : #'code generation' }
PjWorkspaceGlobalVariable >> emitValue: methodBuilder [

	methodBuilder pushLiteralVariable: self.
]

{ #category : #accessing }
PjWorkspaceGlobalVariable >> key: anObject [
	super key: anObject  asSymbol.
]

{ #category : #accessing }
PjWorkspaceGlobalVariable >> value [
	nil == value ifFalse: [ ^ value ].
	^ self error: 'Global not defined in Javascript engine: ',self key
]

{ #category : #accessing }
PjWorkspaceGlobalVariable >> value: anObject [
	^ self error: 'Cannot assign to Javascript global variable: ',self key
]
