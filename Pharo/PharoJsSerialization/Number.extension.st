Extension { #name : #Number }

{ #category : #'*PharoJsSerialization' }
Number >> jsonSerializeWith: aSerializer [
	^aSerializer serializeLiteral: self
]
