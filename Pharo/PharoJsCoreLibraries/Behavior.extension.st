Extension { #name : #Behavior }

{ #category : #'*PharoJsCoreLibraries' }
Behavior class >> javascriptPlaceholder [
	^PjClass
]

{ #category : #'*PharoJsCoreLibraries' }
Behavior >> subclassesDo: aBlock [
	"Evaluate the argument, aBlock, for each of the receiver's immediate subclasses."
	self subclasses do: aBlock
]
