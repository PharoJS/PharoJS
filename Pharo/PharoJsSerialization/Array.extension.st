Extension { #name : #Array }

{ #category : #'*PharoJsSerialization' }
Array >> jsonSerializeWith: aSerializer [
	^aSerializer serializeArray: self

]

{ #category : #'*PharoJsSerialization' }
Array class >> materializeWith: anObject contents: aJsonArray [
	^self new: aJsonArray size

]

{ #category : #'*PharoJsSerialization' }
Array >> materializer: materializer initWith: contentsDescription [
	| elementDescription element |
	contentsDescription withIndexDo: [ : serializationIndex : myIndex |
		element := materializer materializationAt:  serializationIndex.
		self at: myIndex put: element
	]
]
