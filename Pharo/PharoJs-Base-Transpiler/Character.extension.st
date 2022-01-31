Extension { #name : #Character }

{ #category : #'*PharoJs-Base-Transpiler' }
Character >> asJSON [
	^ self asString asJSON
]

{ #category : #'*PharoJs-Base-Transpiler' }
Character >> isLiteralJavascriptValue [
	^ true
]

{ #category : #'*PharoJs-Base-Transpiler' }
Character >> printJsOn: jsStream [
	^self asString printJsOn: jsStream
]
