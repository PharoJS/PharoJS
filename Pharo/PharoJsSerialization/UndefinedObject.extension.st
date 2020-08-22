Extension { #name : #UndefinedObject }

{ #category : #'*PharoJsSerialization' }
UndefinedObject >> writePhxJsonOn: w [
	w << 'null'
]
