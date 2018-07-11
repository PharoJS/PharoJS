Extension { #name : #String }

{ #category : #'*PharoJsCoreLibraries-converting' }
String >> asJsObjectUsing: converter [
	^self
]

{ #category : #'*PharoJsCoreLibraries' }
String class >> javascriptPlaceholder [
	^ PjString
]
