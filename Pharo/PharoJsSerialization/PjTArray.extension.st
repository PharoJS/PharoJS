Extension { #name : #PjTArray }

{ #category : #'*PharoJsSerialization' }
PjTArray classSide >> newFromMaterialized: aJsonArray [
	| materializedArray |
	materializedArray := self new.
	aJsonArray do: [ : each | materializedArray add: each materialize].
	^materializedArray
]

{ #category : #'*PharoJsSerialization' }
PjTArray >> serializationContents [
	"Important not to use a collect to ensure that we have an OrderedCollection that is actually a JS array. Since JSON knows how to handle arrays."
	| serializableElements |
	serializableElements := OrderedCollection new.
	self do: [ : each | serializableElements add: each serializationArray ].
	^serializableElements
]
