Extension { #name : #PjString }

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
