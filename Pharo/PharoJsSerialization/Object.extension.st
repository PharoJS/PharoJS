Extension { #name : #Object }

{ #category : #'*PharoJsSerialization' }
Object >> jsonSerialize [
	^ PjSerializer serialize: self
]
