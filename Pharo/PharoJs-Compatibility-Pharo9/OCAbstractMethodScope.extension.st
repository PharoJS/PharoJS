Extension { #name : #OCAbstractMethodScope }

{ #category : #'*PharoJs-Compatibility-Pharo9' }
OCAbstractMethodScope >> lookupVar: name inContext: aContext [
	"We lookup a variable in a context. If it not in this context, we look in the outer context using the corresponding outer scope"
	
		| variable theValue |
	variable := self
		variableNamed: name
		ifAbsent: [ 	^self outerScopeLookupVar: name inContext: aContext].
	theValue := variable readFromContext: aContext scope: self.
	^ theValue
]

{ #category : #'*PharoJs-Compatibility-Pharo9' }
OCAbstractMethodScope >> outerScopeLookupVar: name inContext: aContext [
	Error signal: 'Cannot find variable named''', name, ''' in this method'
]

{ #category : #'*PharoJs-Compatibility-Pharo9' }
OCAbstractMethodScope >> variableNamed: name ifAbsent: aBlock [
	copiedVars at: name ifPresent: [:v | ^ v].
	tempVector  at: name ifPresent: [:v | ^ v].
	tempVars at: name ifPresent: [:v | ^ v].
	name = 'thisContext' ifTrue: [^ ThisContextVariable instance ].
	
	^ aBlock value.
]
