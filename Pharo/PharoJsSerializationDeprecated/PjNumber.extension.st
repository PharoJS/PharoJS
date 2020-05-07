Extension { #name : #PjNumber }

{ #category : #'*PharoJsSerializationDeprecated' }
PjNumber class >> newFromMaterialized: materializedObject [
	^materializedObject
]

{ #category : #'*PharoJsSerializationDeprecated' }
PjNumber >> serializationContents [
	^self
]
