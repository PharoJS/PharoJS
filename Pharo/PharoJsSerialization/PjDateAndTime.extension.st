Extension { #name : #PjDateAndTime }

{ #category : #'*PharoJsSerialization' }
PjDateAndTime class >> instantiateWithPhxJsonReader: reader instanceJsonObject: str [
	<javascript: 'return new Date(str);'>
]

{ #category : #'*PharoJsSerialization' }
PjDateAndTime class >> phxJsonClassName [
	^ 'DateAndTime'
]

{ #category : #'*PharoJsSerialization' }
PjDateAndTime >> writePhxJsonRepresentationOn: w [
	w writeQuoted: "self yyyymmdd" self toISOString "toString"
]
