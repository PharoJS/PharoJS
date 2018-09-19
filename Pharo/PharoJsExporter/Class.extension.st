Extension { #name : #Class }

{ #category : #'*PharoJsExporter-App' }
Class >> allSharedPoolsRecursive [
	"Answer a set of the pools the receiver shares, including those defined  in the superclasses of the receiver."
	^ self allSharedPoolsRecursiveInto: Set new
]

{ #category : #'*PharoJsExporter-App' }
Class >> allSharedPoolsRecursiveInto: aCollection [
	"Add to the collection all of the pools the receiver shares, including those defined  in the superclasses of the receiver."
	self inheritedSharedPools do: [ : each |
		(aCollection includes: each) ifFalse: [
			aCollection add: each.
			each allSharedPoolsRecursiveInto: aCollection
		]
	].
	^ aCollection
]

{ #category : #'*PharoJsExporter-App' }
Class >> inheritedSharedPools [
	^ self allSharedPools
]

{ #category : #'*PharoJsExporter' }
Class >> javascriptIsExportableClass [
	^ true
]

{ #category : #'*PharoJsExporter-App' }
Class >> sharedPoolOfVarNamedRecursive: aString [
	"Returns the SharedPool or nil from which the pool variable named aString is coming from."
	
	 ^ self allSharedPoolsRecursive 
			detect: [:each | each usesClassVarNamed: aString ]
			ifNone: [ nil ]
]
