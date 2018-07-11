Extension { #name : #UndefinedObject }

{ #category : #'*PharoJsCoreLibraries-converting' }
UndefinedObject >> asJsObjectUsing: converter [
	^self
]

{ #category : #'*PharoJsCoreLibraries' }
UndefinedObject class >> javascriptPlaceholder [
	^ PjUndefinedObject
]
