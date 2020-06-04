Extension { #name : #OCBlockScope }

{ #category : #'*PharoJsCoreLibraries' }
OCBlockScope >> outerScopeLookupVar: name inContext: aContext [
	^ self outerScope 
		lookupVar: name
		inContext: (self nextOuterScopeContextOf: aContext)
]
