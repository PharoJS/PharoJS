Extension { #name : #Context }

{ #category : #'*PharoJs-Base-Transpiler' }
Context >> forScope: aScope [ 
	self sourceNode scope == aScope ifTrue: [ ^self ].
	^self outerContext forScope: aScope
]
