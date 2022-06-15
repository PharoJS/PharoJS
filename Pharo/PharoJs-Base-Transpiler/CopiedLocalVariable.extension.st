Extension { #name : #CopiedLocalVariable }

{ #category : #'*PharoJs-Base-Transpiler' }
CopiedLocalVariable >> readFromContext: aContext scope: aScope closure: aClosedFullBlockClosure [ 
	^aClosedFullBlockClosure copiedValueAt: self index
]
