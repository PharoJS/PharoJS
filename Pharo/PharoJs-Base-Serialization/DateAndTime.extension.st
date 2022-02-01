Extension { #name : #DateAndTime }

{ #category : #'*PharoJs-Base-Serialization' }
DateAndTime class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	^self fromString: jsonObject
]

{ #category : #'*PharoJs-Base-Serialization' }
DateAndTime >> writePhxJsonOn: w [
	self writePhxJsonObjectOn: w
]

{ #category : #'*PharoJs-Base-Serialization' }
DateAndTime >> writePhxJsonRepresentationOn: w [
	w writeQuoted: self asUTC asString
]
