Extension { #name : #Behavior }

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
Behavior class >> javascriptPlaceholder [
	^PjClass
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
Behavior >> subclassesDo: aBlock [
	"Evaluate the argument, aBlock, for each of the receiver's immediate subclasses."
	self subclasses do: aBlock
]
