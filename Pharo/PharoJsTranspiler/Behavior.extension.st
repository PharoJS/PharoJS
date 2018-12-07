Extension { #name : #Behavior }

{ #category : #'*PharoJsTranspiler' }
Behavior >> javascriptInheritsFrom: aClass [ 
	"Answer whether the argument, aClass, is on the receiver's superclass 
	chain."

	| aSuperclass jsClass |
	jsClass := aClass javascriptPlaceholderInheritance.
	aSuperclass := self superclass.
	[aSuperclass == nil]
		whileFalse: 
			[aSuperclass javascriptPlaceholderInheritance == jsClass ifTrue: [^true].
			aSuperclass := aSuperclass superclass].
	^false
]
