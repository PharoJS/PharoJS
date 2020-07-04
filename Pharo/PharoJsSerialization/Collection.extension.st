Extension { #name : #Collection }

{ #category : #'*PharoJsSerialization' }
Collection class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
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

{ #category : #'*PharoJsSerialization' }
Collection >> writePhxJsonRepresentationOn: w [
	w
		doBetweenSquareBrackets: [ self
				do: [ :each | each writePhxJsonOn: w ]
				separatedBy: [ w comma ] ]
]
