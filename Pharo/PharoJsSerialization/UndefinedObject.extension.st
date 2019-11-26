Extension { #name : #UndefinedObject }

{ #category : #'*PharoJsSerialization' }
UndefinedObject >> jsonSerializeWith: aSerializer [
	"Use nil instead of self to ensure it is transpiled to undefined and serialization is properly performed"
	^aSerializer serializeLiteral: nil
]
