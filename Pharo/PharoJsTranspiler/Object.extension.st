Extension { #name : #Object }

{ #category : #'*PharoJsTranspiler' }
Object >> asJSON [
	^ String streamContents: [:s | self printJsOn: s] 
]

{ #category : #'*PharoJsTranspiler' }
Object >> asJsAstUsing: astConverter [
	^PjUnparsedStringNode string: self asJSON
]

{ #category : #'*PharoJsTranspiler' }
Object >> convertToJavascriptAstUsing: aPjAstConverter [
	^ PjLiteralValueNode value: self
]

{ #category : #'*PharoJsTranspiler' }
Object >> convertToJsUsing: aPjTranspiler [
	self printJsOn: aPjTranspiler
]

{ #category : #'*PharoJsTranspiler' }
Object >> isLiteralJavascriptValue [
	^ false
]

{ #category : #'*PharoJsTranspiler' }
Object >> isPjJavascriptAstNode [
	^false
]

{ #category : #'*PharoJsTranspiler' }
Object >> isSimilarTo: anObject [
	^self = anObject
]

{ #category : #'*PharoJsTranspiler' }
Object >> printJsOn: aStream [
	self printOn: aStream
]
