Extension { #name : #PjBoolean }

{ #category : #'*PharoJsSerializationDeprecated' }
PjBoolean class >> newFromMaterialized: materializedObject [
	^materializedObject
]

{ #category : #'*PharoJsSerializationDeprecated' }
PjBoolean >> serializationContents [
	^self
]
