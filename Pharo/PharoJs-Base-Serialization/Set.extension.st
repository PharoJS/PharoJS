Extension { #name : #Set }

{ #category : #'*PharoJs-Base-Serialization' }
Set class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| newCollection |
	newCollection := self new.
	reader addKnownObject: newCollection.
	jsonObject do: [ : each | newCollection add: (reader readFromJsObjectOrDictionary: each) ].
	^newCollection
]
