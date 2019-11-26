Extension { #name : #PjTDate }

{ #category : #'*PharoJsSerialization' }
PjTDate >> jsonSerializeWith: aSerializer [
	^aSerializer serializeDateOrTime: self
]

{ #category : #'*PharoJsSerialization' }
PjTDate classSide >> newFromMaterialized: jsonString [
	<javascript: 'return new Date(jsonString)'>
	
]

{ #category : #'*PharoJsSerialization' }
PjTDate classSide >> newFromMaterializedJSON: jsonString [
	<javascript: 'return new Date(jsonString)'>
	
]
