Extension { #name : #PjJavascriptAstNode }

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjJavascriptAstNode >> constantOrZero [
	^ 0
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjJavascriptAstNode >> isArray [
	^ false
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjJavascriptAstNode >> isBlock [
	^ false
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjJavascriptAstNode >> isClass: aClass ifNot: aBlockClosure [
	myClass == aClass ifFalse: [
		myClass ifNil: [ aBlockClosure value ].
		(myClass inheritsFrom: aClass) ifFalse: [ aBlockClosure value ]]
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjJavascriptAstNode >> isLiteralFalse [
	^ false
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjJavascriptAstNode >> isLiteralTrue [
	^ false
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjJavascriptAstNode >> isNonArray [
	^ false
]
