Extension { #name : #UndefinedObject }

{ #category : #'*PharoJsTranspiler' }
UndefinedObject >> asJSON [
	^ #undefined
]

{ #category : #'*PharoJsTranspiler' }
UndefinedObject >> isLiteralJavascriptValue [
	^ true
]

{ #category : #'*PharoJsTranspiler' }
UndefinedObject >> printJsOn: aStream [
	aStream nextPutAll: self asJSON
]
