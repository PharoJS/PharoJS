Extension { #name : #Number }

{ #category : #'*PharoJs-Base-Serialization' }
Number >> writePhxJsonOn: w [
	w << self asString
]
