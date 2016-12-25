Extension { #name : #ProtoObject }

{ #category : #'*PharoJsTranspiler' }
ProtoObject class >> classToUseForJsConversion [
	self hasJavascriptPlaceholder ifFalse: [ ^self].
	^self javascriptPlaceholder
]

{ #category : #'*PharoJsTranspiler' }
ProtoObject class >> hasClassMethod: selector [
	^self class includesSelector: selector
]

{ #category : #'*PharoJsTranspiler' }
ProtoObject class >> hasJavascriptPlaceholder [
	^self hasClassMethod: #javascriptPlaceholder
]

{ #category : #'*PharoJsTranspiler' }
ProtoObject class >> javascriptPlaceholderInheritance [
	self hasJavascriptPlaceholder ifTrue: [ ^ self javascriptPlaceholder].
	^ self
]
