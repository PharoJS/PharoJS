Extension { #name : #PjUndefinedObject }

{ #category : #'*PharoJsSerialization' }
PjUndefinedObject >> writePhxJsonOn: w [
	w << 'null'
]
