Extension { #name : #Metaclass }

{ #category : #'*PharoJs-Base-Transpiler' }
Metaclass >> classToUseForJsConversion [
	^ self instanceSide classToUseForJsConversion classSide
]
