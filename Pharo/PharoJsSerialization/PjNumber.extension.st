Extension { #name : #PjNumber }

{ #category : #'*PharoJsSerialization' }
PjNumber class >> newFromMaterialized: materializedObject [
	^materializedObject
]

{ #category : #'*PharoJsSerialization' }
PjNumber >> serializationContents [
	^self
]
