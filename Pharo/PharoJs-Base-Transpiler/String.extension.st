Extension { #name : #String }

{ #category : #'*PharoJs-Base-Transpiler' }
String >> isLiteralJavascriptValue [
	^ true
]

{ #category : #'*PharoJs-Base-Transpiler' }
String >> printJsOn: aStream [
	aStream nextPut: $".
	self do: [ : each |
		self printOneJsCharacter: each asInteger onStream: aStream ].
	aStream nextPut: $".
]

{ #category : #'*PharoJs-Base-Transpiler' }
String >> printOneJsCharacter: each onStream: aStream [
	each < 32 ifTrue: [
		aStream nextPut: $\.
		each = 10
			ifTrue: [ aStream nextPut: $n ]
			ifFalse: [ each = 13
					ifTrue: [ aStream nextPut: $r ]
					ifFalse: [
						aStream nextPut: $x.
						aStream nextPutAll: (each printStringBase: 16 nDigits: 2) ] ] 
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
