Extension { #name : #DateAndTime }

{ #category : #'*PharoJsSerialization' }
DateAndTime class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	^self fromString: jsonObject
]

{ #category : #'*PharoJsSerialization' }
DateAndTime >> writePhxJsonOn: w [
	self writePhxJsonObjectOn: w
]

{ #category : #'*PharoJsSerialization' }
DateAndTime >> writePhxJsonRepresentationOn: w [
	w writeQuoted: self asUTC asString
]
