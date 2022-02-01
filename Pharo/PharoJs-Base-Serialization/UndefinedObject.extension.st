Extension { #name : #UndefinedObject }

{ #category : #'*PharoJs-Base-Serialization' }
UndefinedObject >> writePhxJsonOn: w [
	w << 'null'
]
