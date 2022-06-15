Extension { #name : #CopiedLocalVariable }

{ #category : #'*PharoJs-Base-Transpiler' }
CopiedLocalVariable >> readFromContext: aContext scope: anOCBlockScope closure: aPjClosedFullBlockClosure [ 
	^aPjClosedFullBlockClosure copiedValueAt: self index
]
