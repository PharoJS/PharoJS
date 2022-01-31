Extension { #name : #Dictionary }

{ #category : #'*PharoJs-Base-Transpiler' }
Dictionary >> isFreeJavascriptValue [
	self keysAndValuesDo: [ : key : value |
		key isString ifFalse: [ ^ false ] .
		value isFreeJavascriptValue ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'*PharoJs-Base-Transpiler' }
Dictionary >> isLiteralJavascriptValue [
	self keysAndValuesDo: [ : key : value |
		key isString ifFalse: [ ^ false ] .
		value isLiteralJavascriptValue ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'*PharoJs-Base-Transpiler' }
Dictionary >> printJsOn: aStream [
	| first |
	first := true.
	aStream nextPut: ${.
	self keysAndValuesDo:  [ : key : value |
			first ifFalse: [ aStream nextPut: $, ].
			key printJsOn: aStream.
			aStream nextPut: $:.
			value printJsOn: aStream.
			first := false
	].
	aStream nextPut: $}
]
