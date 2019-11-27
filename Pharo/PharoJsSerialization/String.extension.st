Extension { #name : #String }

{ #category : #'*PharoJsSerialization' }
String >> jsonSerializeWith: aSerializer [
	^aSerializer serializeLiteral: self
]
