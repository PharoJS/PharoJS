Extension { #name : #PjUndefinedObject }

{ #category : #'*PharoJs-Base-Serialization' }
PjUndefinedObject >> writePhxJsonOn: w [
	w << 'null'
]
