Extension { #name : #PjNumber }

{ #category : #'*PharoJs-Base-Serialization' }
PjNumber >> writePhxJsonOn: w [
	w << self asString
]
