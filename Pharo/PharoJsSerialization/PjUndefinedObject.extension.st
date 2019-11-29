Extension { #name : #PjUndefinedObject }

{ #category : #'*PharoJsSerialization' }
PjUndefinedObject class >> newFromMaterialized: anObject [
	^nil
]

{ #category : #'*PharoJsSerialization' }
PjUndefinedObject >> serializationContents [
	^self
]
