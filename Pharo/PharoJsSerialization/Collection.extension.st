Extension { #name : #Collection }

{ #category : #'*PharoJsSerialization' }
Collection class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	^ self
		withAll:
			(jsonObject collect: [ :each | reader readFromJsObjectOrDictionary: each ])
]

{ #category : #'*PharoJsSerialization' }
Collection >> writePhxJsonRepresentationOn: w [
	w
		doBetweenSquareBrackets: [ self
				do: [ :each | each writePhxJsonOn: w ]
				separatedBy: [ w comma ] ]
]
