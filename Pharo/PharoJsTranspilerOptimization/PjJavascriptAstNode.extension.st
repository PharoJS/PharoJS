Extension { #name : #PjJavascriptAstNode }

{ #category : #'*PharoJsTranspilerOptimization' }
PjJavascriptAstNode >> constantOrZero [
	^ 0
]

{ #category : #'*PharoJsTranspilerOptimization' }
PjJavascriptAstNode >> isArray [
	^ false
]

{ #category : #'*PharoJsTranspilerOptimization' }
PjJavascriptAstNode >> isBlock [
	^ false
]

{ #category : #'*PharoJsTranspilerOptimization' }
PjJavascriptAstNode >> isClass: aClass ifNot: aBlockClosure [
	myClass == aClass ifFalse: [
		myClass ifNil: [ aBlockClosure value ].
		(myClass inheritsFrom: aClass) ifFalse: [ aBlockClosure value ]]
]

{ #category : #'*PharoJsTranspilerOptimization' }
PjJavascriptAstNode >> isLiteralFalse [
	^ false
]

{ #category : #'*PharoJsTranspilerOptimization' }
PjJavascriptAstNode >> isLiteralTrue [
	^ false
]

{ #category : #'*PharoJsTranspilerOptimization' }
PjJavascriptAstNode >> isNonArray [
	^ false
]
