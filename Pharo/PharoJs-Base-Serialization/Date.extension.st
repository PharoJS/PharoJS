Extension { #name : #Date }

{ #category : #'*PharoJs-Base-Serialization' }
Date class >> instantiateWithPhxJsonReader: reader instanceJsonObject: aString [
	^self readFrom: (aString ifNotNilOrEmpty: [aString first:10]) pattern: 'yyyy-mm-dd'
]

{ #category : #'*PharoJs-Base-Serialization' }
Date >> writePhxJsonOn: w [
	self writePhxJsonObjectOn: w
]

{ #category : #'*PharoJs-Base-Serialization' }
Date >> writePhxJsonRepresentationOn: w [
	w writeQuoted: self yyyymmdd
]
