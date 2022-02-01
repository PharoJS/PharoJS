Extension { #name : #PjTDate }

{ #category : #'*PharoJs-Base-Serialization-Deprecated' }
PjTDate classSide >> newFromMaterialized: jsonString [
	<javascript: 'return new Date(jsonString)'>
]

{ #category : #'*PharoJs-Base-Serialization-Deprecated' }
PjTDate >> serializationContents [
	^self
]
