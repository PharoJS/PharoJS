Extension { #name : #Boolean }

{ #category : #'*PharoJsSerialization' }
Boolean >> jsonSerializeWith: aSerializer [
	^aSerializer serializeLiteral: self
]

{ #category : #'*PharoJsSerialization' }
Boolean class >> newFromMaterialized: materializedObject [
	^materializedObject
]
