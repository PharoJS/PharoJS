Extension { #name : #UndefinedObject }

{ #category : #'*PharoJs-Base-Transpiler' }
UndefinedObject >> asJSON [
	^ #undefined
]

{ #category : #'*PharoJs-Base-Transpiler' }
UndefinedObject >> isLiteralJavascriptValue [
	^ true
]

{ #category : #'*PharoJs-Base-Transpiler' }
UndefinedObject >> printJsOn: aStream [
	aStream nextPutAll: self asJSON
]
