Extension { #name : #UndefinedObject }

{ #category : #'*PharoJsSerialization' }
UndefinedObject >> jsonSerializeWith: aSerializer [
	^aSerializer serializeNil
]

{ #category : #'*PharoJsSerialization' }
UndefinedObject class >> newFromMaterialized: anObject [
	^nil
]
