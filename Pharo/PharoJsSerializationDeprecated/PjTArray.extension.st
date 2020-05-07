Extension { #name : #PjTArray }

{ #category : #'*PharoJsSerializationDeprecated' }
PjTArray classSide >> newFromMaterialized: aJsonArray [
	| materializedArray |
	materializedArray := self new.
	aJsonArray do: [ : each | materializedArray add: each materialize].
	^materializedArray
]

{ #category : #'*PharoJsSerializationDeprecated' }
PjTArray >> serializationContents [
	"Important not to use a collect to ensure that we have an OrderedCollection that is actually a JS array. Since JSON knows how to handle arrays."
	| serializableElements |
	serializableElements := OrderedCollection new.
	self do: [ : each | serializableElements add: each serializationArray ].
	^serializableElements
]
