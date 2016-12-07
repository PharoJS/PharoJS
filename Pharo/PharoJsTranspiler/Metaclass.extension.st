Extension { #name : #Metaclass }

{ #category : #'*PharoJsTranspiler' }
Metaclass >> classToUseForJsConversion [
	^ self baseClass classToUseForJsConversion theMetaClass
]
