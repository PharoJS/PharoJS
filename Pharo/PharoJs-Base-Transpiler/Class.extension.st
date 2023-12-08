Extension { #name : #Class }

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> asJsAstUsing: astConverter [

	^ astConverter visitGlobalVariableNamed: self instanceSide name
]

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> classInitializeSelector [
	(self hasClassMethod: #javascriptInitialize) ifTrue: [ ^#javascriptInitialize ].
	^#initialize
]

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> convertToJavascriptAstUsing: aPjAstConverter [

	^ aPjAstConverter visitGlobalVariableNamed: self name
]

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> convertToJsUsing: transpiler [
	transpiler convertClass: self.
]

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> hasJavascriptName [
	^self hasClassMethod: #javascriptName
]

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> isFreeJavascriptValue [
	^ true
]

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> isJsClassPlaceholder [

	self hasJavascriptPlaceholder ifTrue: [ 
		^ self javascriptPlaceholder isJsClassPlaceholder ].
	^self hasJavascriptName and: [self javascriptName ~= self name]
]

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> nameToUseForJsConversion [
	self hasJavascriptPlaceholder ifTrue: [ ^self javascriptPlaceholder nameToUseForJsConversion].
	self hasJavascriptName ifFalse: [ ^self name].
	^self javascriptName
]

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> needsClassDeclaration [

	^self isJsClassPlaceholder not
]

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> needsInitialization [

	^ (self hasClassMethod: #initialize) or: [
		  (self hasClassMethod: #javascriptInitialize) or: [
			  self class allSlots anySatisfy: #needsJavascriptInitialization ] ]
]

{ #category : #'*PharoJs-Base-Transpiler' }
Class >> printJsOn: aStream [
	self error: 'Class doesn''t have a literal representation'
]
