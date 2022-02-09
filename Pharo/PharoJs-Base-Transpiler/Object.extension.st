Extension { #name : #Object }

{ #category : #'*PharoJs-Base-Transpiler' }
Object >> asJSON [
	^ String streamContents: [:s | self printJsOn: s]
]

{ #category : #'*PharoJs-Base-Transpiler' }
Object >> asJsAstUsing: astConverter [
	^PjUnparsedStringNode string: self asJSON
]

{ #category : #'*PharoJs-Base-Transpiler' }
Object >> convertToJavascriptAstUsing: aPjAstConverter [
	^ PjLiteralValueNode value: self
]

{ #category : #'*PharoJs-Base-Transpiler' }
Object >> convertToJsUsing: aPjTranspiler [
	self printJsOn: aPjTranspiler
]

{ #category : #'*PharoJs-Base-Transpiler' }
Object >> isFreeJavascriptValue [
	^ self isLiteralJavascriptValue
]

{ #category : #'*PharoJs-Base-Transpiler' }
Object >> isLiteralJavascriptValue [
	^ false
]

{ #category : #'*PharoJs-Base-Transpiler' }
Object >> isPjJavascriptAstNode [
	^false
]

{ #category : #'*PharoJs-Base-Transpiler' }
Object >> isSimilarTo: anObject [
	^self = anObject
]

{ #category : #'*PharoJs-Base-Transpiler' }
Object >> printJsOn: aStream [
	self printOn: aStream
]
