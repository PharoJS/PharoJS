Extension { #name : #Number }

{ #category : #'*PharoJsSerialization' }
Number >> writePhxJsonOn: w [
	w << self asString
]
