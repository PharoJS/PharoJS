Extension { #name : #PjString }

{ #category : #'*PharoJsSerialization' }
PjString >> initAfterMaterializationWith: materializedObjects [
	^self
]

{ #category : #'*PharoJsSerialization' }
PjString >> materialize [
	^PjMaterializer materializeFromString: self
]

{ #category : #'*PharoJsSerialization' }
PjString >> serializationContents [
	^self
]
