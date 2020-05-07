Extension { #name : #PjString }

{ #category : #'*PharoJsSerializationDeprecated' }
PjString >> materialize [
	^PjMaterializer materializeFromString: self
]

{ #category : #'*PharoJsSerializationDeprecated' }
PjString class >> newFromMaterialized: materializedObject [
	^materializedObject
]

{ #category : #'*PharoJsSerializationDeprecated' }
PjString >> serializationContents [
	^self
]
