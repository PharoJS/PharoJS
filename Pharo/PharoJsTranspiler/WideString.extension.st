Extension { #name : #WideString }

{ #category : #'*PharoJsTranspiler' }
WideString >> printJsOn: aStream [
	aStream nextPut: $".
	(ZnUTF8Encoder new encodeString: self) do: [ :each |
		self printOneJsCharacter: each onStream: aStream ].
	aStream nextPut: $"
]
