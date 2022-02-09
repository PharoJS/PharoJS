Extension { #name : #String }

{ #category : #'*PharoJs-Base-Serialization' }
String >> writePhxJsonOn: w [
	w << (STONJSON toString: self)
]
