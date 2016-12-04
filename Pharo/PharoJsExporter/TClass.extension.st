Extension { #name : #TClass }

{ #category : #'*PharoJsExporter-App' }
TClass >> allSharedPoolsRecursive [
	"Answer an ordered collection of the pools the receiver shares, including those defined  in the superclasses of the receiver."
	| aSet additions new |
	self superclass == nil
		ifTrue: [aSet := Set new]
		ifFalse: [aSet := self superclass allSharedPoolsRecursive].
	additions := self sharedPools.
	[ additions isEmpty ] whileFalse: [
		new := Set new.
		additions do: [ : each |
			(aSet includes: each) ifFalse: [
				aSet add: each.
				new addAll: each allSharedPools
			]
		].
		additions := new
	].
	^ aSet
]

{ #category : #'*PharoJsExporter-App' }
TClass >> sharedPoolOfVarNamedRecursive: aString [
	"Returns the SharedPool or nil from which the pool variable named aString is coming from."
	
	 ^ self allSharedPoolsRecursive 
			detect: [:each | each usesClassVarNamed: aString ]
			ifNone: [ nil ]
]
