Extension { #name : #Date }

{ #category : #'*PharoJsSerialization' }
Date class >> instantiateWithPhxJsonReader: reader instanceJsonObject: aString [
	^self readFrom: (aString ifNotNilOrEmpty: [aString first:10]) pattern: 'yyyy-mm-dd'
]

{ #category : #'*PharoJsSerialization' }
Date >> writePhxJsonOn: w [
	self writePhxJsonObjectOn: w
]

{ #category : #'*PharoJsSerialization' }
Date >> writePhxJsonRepresentationOn: w [
	w writeQuoted: self yyyymmdd
]
