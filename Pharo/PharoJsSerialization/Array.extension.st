Extension { #name : #Array }

{ #category : #'*PharoJsSerialization' }
Array >> jsonSerializeWith: aSerializer [
	^aSerializer serializeArray: self

]

{ #category : #'*PharoJsSerialization' }
Array class >> newFromMaterialized: aJsonArray [
	^self new: aJsonArray size

]
