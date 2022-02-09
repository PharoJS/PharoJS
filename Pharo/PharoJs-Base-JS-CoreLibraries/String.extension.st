Extension { #name : #String }

{ #category : #'*PharoJs-Base-JS-CoreLibraries-converting' }
String >> asJsObjectUsing: converter [
	^self
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
String class >> javascriptPlaceholder [
	^ PjString
]
