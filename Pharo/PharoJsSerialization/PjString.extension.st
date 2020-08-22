Extension { #name : #PjString }

{ #category : #'*PharoJsSerialization' }
PjString >> writePhxJsonOn: w [
	w << self asJSON
]
