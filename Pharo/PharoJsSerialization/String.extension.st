Extension { #name : #String }

{ #category : #'*PharoJsSerialization' }
String >> writePhxJsonOn: w [
	w << (STONJSON toString: self)
	


]
