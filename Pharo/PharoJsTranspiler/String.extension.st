Extension { #name : #String }

{ #category : #'*PharoJsTranspiler' }
String >> basicConvertToJsUsing: transpiler [
	^transpiler basicConvertString: self
]

{ #category : #'*PharoJsTranspiler' }
String >> isLiteralJavascriptValue [
	^ true
]

{ #category : #'*PharoJsTranspiler' }
String >> printJsOn: aStream [
	aStream nextPut: $".
	self do: [ : each |
		self printOneJsCharacter: each asInteger onStream: aStream ].
	aStream nextPut: $".
]

{ #category : #'*PharoJsTranspiler' }
String >> printOneJsCharacter: each onStream: aStream [
	each < 32 ifTrue: [
		aStream nextPut: $\.
		each = 10
			ifTrue: [ aStream nextPut: $n ]
			ifFalse: [ each = 13
					ifTrue: [ aStream nextPut: $r ]
					ifFalse: [
						aStream nextPut: $0.
						aStream nextPut: ('0123' at: each // 8 + 1).
						aStream nextPut: ('01234567' at: each \\ 8 + 1) ] ] 
	] ifFalse: [
		each < 128 ifTrue: [
			each = 34 ifTrue: [ aStream nextPut: $\ ].
			each = 92 ifTrue: [ aStream nextPut: $\ ].
			aStream nextPut: (Character value: each).
		] ifFalse: [
			aStream nextPut: $\.
			aStream nextPut: $u.
			aStream nextPutAll: (each printStringBase: 16 nDigits: 4).
	]]
]
