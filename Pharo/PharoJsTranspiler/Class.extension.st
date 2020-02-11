Extension { #name : #Class }

{ #category : #'*PharoJsTranspiler' }
Class >> asJsAstUsing: astConverter [
	^ astConverter
		visitGlobalNode: (RBGlobalNode named: self instanceSide name)
]

{ #category : #'*PharoJsTranspiler' }
Class >> classInitializeSelector [
	(self hasClassMethod: #javascriptInitialize) ifTrue: [ ^#javascriptInitialize ].
	^#initialize
]

{ #category : #'*PharoJsTranspiler' }
Class >> convertToJavascriptAstUsing: aPjAstConverter [
	^ aPjAstConverter visit: (RBGlobalNode named: self name)
]

{ #category : #'*PharoJsTranspiler' }
Class >> convertToJsUsing: transpiler [
	transpiler convertClass: self.

]

{ #category : #'*PharoJsTranspiler' }
Class >> hasJavascriptName [
	^self hasClassMethod: #javascriptName
]

{ #category : #'*PharoJsTranspiler' }
Class >> isFreeJavascriptValue [
	^ true
]

{ #category : #'*PharoJsTranspiler' }
Class >> nameToUseForJsConversion [
	self hasJavascriptPlaceholder ifTrue: [ ^self javascriptPlaceholder nameToUseForJsConversion].
	self hasJavascriptName ifFalse: [ ^self name].
	^self javascriptName
]

{ #category : #'*PharoJsTranspiler' }
Class >> needsClassDefinition [
	self hasJavascriptPlaceholder ifTrue: [ ^self javascriptPlaceholder needsClassDefinition].
	self hasJavascriptName ifFalse: [ ^true].
	^self javascriptName = self name
]

{ #category : #'*PharoJsTranspiler' }
Class >> needsInitialization [
	^(self hasClassMethod: #initialize) or: [ self hasClassMethod: #javascriptInitialize ]
]

{ #category : #'*PharoJsTranspiler' }
Class >> printJsOn: aStream [
	self error: 'Class doesn''t have a literal representation'
]
