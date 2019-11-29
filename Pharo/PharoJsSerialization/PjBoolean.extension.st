Extension { #name : #PjBoolean }

{ #category : #'*PharoJsSerialization' }
PjBoolean class >> newFromMaterialized: materializedObject [
	^materializedObject
]

{ #category : #'*PharoJsSerialization' }
PjBoolean >> serializationContents [
	^self
]
