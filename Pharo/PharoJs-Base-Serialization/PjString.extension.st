Extension { #name : #PjString }

{ #category : #'*PharoJs-Base-Serialization' }
PjString >> writePhxJsonOn: w [
	w << self asJSON
]
