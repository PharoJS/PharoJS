Extension { #name : #PjTArray }

{ #category : #'*PharoJsSerialization' }
PjTArray classSide >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| resultCollection elements |
	resultCollection := self new: jsonObject size.
	reader addKnownObject: resultCollection.
	elements := jsonObject collect: [ :each | reader readFromJsObjectOrDictionary: each ].
	^resultCollection
		addAll: elements;
		yourself
]
