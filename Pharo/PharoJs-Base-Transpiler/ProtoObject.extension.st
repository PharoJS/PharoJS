Extension { #name : #ProtoObject }

{ #category : #'*PharoJs-Base-Transpiler' }
ProtoObject class >> classToUseForJsConversion [
	self hasJavascriptPlaceholder ifFalse: [ ^self].
	^self javascriptPlaceholder
]

{ #category : #'*PharoJs-Base-Transpiler' }
ProtoObject class >> hasClassMethod: selector [
	^self classSide includesSelector: selector
]

{ #category : #'*PharoJs-Base-Transpiler' }
ProtoObject class >> hasInstanceMethod: selector [
	^self instanceSide includesSelector: selector
]

{ #category : #'*PharoJs-Base-Transpiler' }
ProtoObject class >> hasJavascriptPlaceholder [
	^self hasClassMethod: #javascriptPlaceholder
]

{ #category : #'*PharoJs-Base-Transpiler' }
ProtoObject class >> javascriptPlaceholderInheritance [
	self hasJavascriptPlaceholder ifTrue: [ ^ self javascriptPlaceholder].
	^ self
]
