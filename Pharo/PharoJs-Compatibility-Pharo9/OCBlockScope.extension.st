Extension { #name : #OCBlockScope }

{ #category : #'*PharoJs-Compatibility-Pharo9' }
OCBlockScope >> outerScopeLookupVar: name inContext: aContext [
	^ self outerScope 
		lookupVar: name
		inContext: (self nextOuterScopeContextOf: aContext)
]
