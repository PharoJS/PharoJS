Extension { #name : #Boolean }

{ #category : #'*PharoJsCoreLibraries-converting' }
Boolean >> asJsObjectUsing: converter [
	^self
]

{ #category : #'*PharoJsCoreLibraries' }
Boolean class >> javascriptPlaceholder [
	^ PjBoolean
]
