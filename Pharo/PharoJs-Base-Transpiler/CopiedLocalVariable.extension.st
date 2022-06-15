Extension { #name : #CopiedLocalVariable }

{ #category : #'*PharoJs-Base-Transpiler' }
CopiedLocalVariable >> readFromContext: aContext scope: anOCBlockScope closure: aPjClosedFullBlockClosure [ 
	self scope == anOCBlockScope ifFalse: [ ^self readFromContext: aContext  scope: anOCBlockScope].
	^aPjClosedFullBlockClosure copiedValueAt: self index
]
