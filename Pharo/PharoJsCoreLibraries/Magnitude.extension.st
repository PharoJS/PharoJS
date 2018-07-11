Extension { #name : #Magnitude }

{ #category : #'*PharoJsCoreLibraries-converting' }
Magnitude >> asJsObjectUsing: converter [
	^self
]

{ #category : #'*PharoJsCoreLibraries' }
Magnitude class >> javascriptPlaceholder [
	^ PjMagnitude
]
