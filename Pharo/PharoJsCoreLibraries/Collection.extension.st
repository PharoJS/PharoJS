Extension { #name : #Collection }

{ #category : #'*PharoJsCoreLibraries-converting' }
Collection >> asJsObjectUsing: converter [
	^self collect: [ : each | each  asJsObjectUsing: converter]
]

{ #category : #'*PharoJsCoreLibraries' }
Collection class >> javascriptPlaceholder [
	^PjCollection
]
