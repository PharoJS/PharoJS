Extension { #name : #SequenceableCollection }

{ #category : #'*PharoJsSerialization' }
SequenceableCollection class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| resultCollection |
	resultCollection := self ofSize: jsonObject size.
	reader addKnownObject: resultCollection.
	jsonObject
		doWithIndex: [ :each :index | 
			resultCollection
				at: index
				put: (reader readFromJsObjectOrDictionary: each) ].
	^ resultCollection
]
