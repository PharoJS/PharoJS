Extension { #name : #PjString }

{ #category : #'*PharoJsSerialization' }
PjString >> materialize [
	^PjMaterializer materializeFromString: self
]

{ #category : #'*PharoJsSerialization' }
PjString >> materializer: materializer initWith: contentsDescription [
	^self
]

{ #category : #'*PharoJsSerialization' }
PjString >> serializationContents [
	^self
]
