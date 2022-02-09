Extension { #name : #PjDateAndTime }

{ #category : #'*PharoJs-Base-Serialization' }
PjDateAndTime class >> instantiateWithPhxJsonReader: reader instanceJsonObject: str [
	<javascript: 'return new Date(str);'>
]

{ #category : #'*PharoJs-Base-Serialization' }
PjDateAndTime class >> phxJsonClassName [
	^ 'DateAndTime'
]

{ #category : #'*PharoJs-Base-Serialization' }
PjDateAndTime >> writePhxJsonRepresentationOn: w [
	w writeQuoted: "self yyyymmdd" self toISOString "toString"
]
