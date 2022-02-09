Extension { #name : #Boolean }

{ #category : #'*PharoJs-Base-JS-CoreLibraries-converting' }
Boolean >> asJsObjectUsing: converter [
	^self
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
Boolean class >> javascriptPlaceholder [
	^ PjBoolean
]
