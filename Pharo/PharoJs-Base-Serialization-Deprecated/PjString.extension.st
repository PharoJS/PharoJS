Extension { #name : #PjString }

{ #category : #'*PharoJs-Base-Serialization-Deprecated' }
PjString >> materialize [
	^PjMaterializer materializeFromString: self
]

{ #category : #'*PharoJs-Base-Serialization-Deprecated' }
PjString class >> newFromMaterialized: materializedObject [
	^materializedObject
]

{ #category : #'*PharoJs-Base-Serialization-Deprecated' }
PjString >> serializationContents [
	^self
]
