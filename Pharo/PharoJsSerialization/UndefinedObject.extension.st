Extension { #name : #UndefinedObject }

{ #category : #'*PharoJsSerialization' }
UndefinedObject >> jsonSerializeWith: aSerializer [
	^aSerializer serializeNil
]
