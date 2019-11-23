Extension { #name : #PjTDate }

{ #category : #'*PharoJsSerialization' }
PjTDate classSide >> newFromMaterialized: jsonString [
	<javascript: 'return new Date(jsonString)'>
	
]

{ #category : #'*PharoJsSerialization' }
PjTDate >> serializationContents [
	^self
]
