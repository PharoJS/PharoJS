Extension { #name : #String }

{ #category : #'*PharoJsSerialization' }
String >> jsonSerializeWith: aSerializer [
	^aSerializer serializeLiteral: self
]

{ #category : #'*PharoJsSerialization' }
String class >> newFromMaterialized: materializedObject [
	^materializedObject
]
