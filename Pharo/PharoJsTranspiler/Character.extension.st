Extension { #name : #Character }

{ #category : #'*PharoJsTranspiler' }
Character >> asJSON [
	^ self asString asJSON
]

{ #category : #'*PharoJsTranspiler' }
Character >> isLiteralJavascriptValue [
	^ true
]

{ #category : #'*PharoJsTranspiler' }
Character >> printJsOn: jsStream [
	^self asString printJsOn: jsStream
]
