Extension { #name : #Boolean }

{ #category : #'*PharoJsSerialization' }
Boolean >> jsonSerializeWith: aSerializer [
	^aSerializer serializeLiteral: self
]
