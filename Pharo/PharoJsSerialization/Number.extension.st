Extension { #name : #Number }

{ #category : #'*PharoJsSerialization' }
Number >> jsonSerializeWith: aSerializer [
	^aSerializer serializeLiteral: self
]

{ #category : #'*PharoJsSerialization' }
Number class >> newFromMaterialized: materializedObject [
	^materializedObject
]
