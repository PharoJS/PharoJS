Extension { #name : #OCBlockScope }

{ #category : #'*PharoJsPharo8' }
OCBlockScope >> outerScopeLookupVar: name inContext: aContext [
	^ self outerScope 
		lookupVar: name
		inContext: (self nextOuterScopeContextOf: aContext)
]
