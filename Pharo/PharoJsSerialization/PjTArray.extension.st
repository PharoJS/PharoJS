Extension { #name : #PjTArray }

{ #category : #'*PharoJsSerialization' }
PjTArray >> initAfterMaterializationWith: materializedObjects [
	| actualElement |
	self withIndexDo: [ : materizalizationIndex : index |
		actualElement := materializedObjects at: materizalizationIndex.
		self at: index put: actualElement
	]
]

{ #category : #'*PharoJsSerialization' }
PjTArray >> serializationContents [
	"Important not to use a collect to ensure that we have an OrderedCollection that is actually a JS array. Since JSON knows how to handle arrays."
	| serializableElements |
	serializableElements := OrderedCollection new.
	self do: [ : each | serializableElements add: each serializationArray ].
	^serializableElements
]
