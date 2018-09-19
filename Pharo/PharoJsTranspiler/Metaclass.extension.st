Extension { #name : #Metaclass }

{ #category : #'*PharoJsTranspiler' }
Metaclass >> classToUseForJsConversion [
	^ self instanceSide classToUseForJsConversion classSide
]
