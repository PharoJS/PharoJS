Extension { #name : #OCAbstractMethodScope }

{ #category : #'*PharoJsCoreLibraries' }
OCAbstractMethodScope >> lookupVar: name inContext: aContext [
	"We lookup a variable in a context. If it not in this context, we look in the outer context using the corresponding outer scope"
	
		| variable theValue |
	variable := self
		variableNamed: name
		ifAbsent: [ 	^self outerScopeLookupVar: name inContext: aContext].
	theValue := variable readFromContext: aContext scope: self.
	^ theValue
]

{ #category : #'*PharoJsCoreLibraries' }
OCAbstractMethodScope >> lookupVar_old: name inContext: aContext [
	"We lookup a variable in a context. If it not in this context, we look in the outer context using the corresponding outer scope"
	
	| variable theValue |
	self halt.
	variable := self
		variableNamed: name
		ifAbsent: [ 	^self outerScopeLookupVar: name inContext: aContext].
	theValue := variable  readVectorFromContext: aContext scope: self.
	^ theValue
]

{ #category : #'*PharoJsCoreLibraries' }
OCAbstractMethodScope >> outerScopeLookupVar: name inContext: aContext [
	Error signal: 'Cannot find variable named''', name, ''' in this method'
]

{ #category : #'*PharoJsCoreLibraries' }
OCAbstractMethodScope >> variableNamed: name ifAbsent: aBlock [
	copiedVars at: name ifPresent: [:v | ^ v].
	tempVector  at: name ifPresent: [:v | ^ v].
	tempVars at: name ifPresent: [:v | ^ v].
	name = 'thisContext' ifTrue: [^ thisContextVar].
	
	^ aBlock value.
]
