Extension { #name : #CopiedLocalVariable }

{ #category : #'*PharoJs-Base-Transpiler' }
CopiedLocalVariable >> readFromContext: aContext scope: aScope closure: aClosedFullBlockClosure [ 
	| currentContext currentScope localIndex offset value |
	value := self readFromContext: aContext scope: aScope.
	value ifNotNil: [ ^value ].
	currentContext := aContext.
	currentScope := aScope.
	[currentScope localTempNames includes: self name] whileFalse: [
		currentContext := currentContext outerContext.
		currentScope := currentContext sourceNode scope.
	].
	localIndex := currentScope localTempNames indexOf: self name.
	offset := localIndex - 1.
	^currentContext  tempAt: offset.
	

]
