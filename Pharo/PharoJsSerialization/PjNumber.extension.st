Extension { #name : #PjNumber }

{ #category : #'*PharoJsSerialization' }
PjNumber >> writePhxJsonOn: w [
	w << self asString
]
