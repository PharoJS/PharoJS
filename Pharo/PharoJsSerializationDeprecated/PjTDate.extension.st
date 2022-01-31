Extension { #name : #PjTDate }

{ #category : #'*PharoJsSerializationDeprecated' }
PjTDate classSide >> newFromMaterialized: jsonString [
	<javascript: 'return new Date(jsonString)'>
]

{ #category : #'*PharoJsSerializationDeprecated' }
PjTDate >> serializationContents [
	^self
]
