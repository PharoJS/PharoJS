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
PjString class >> newFromMaterialized: materializedObject [
	^materializedObject
]

{ #category : #'*PharoJsSerialization' }
PjString >> serializationContents [
	^self
]
