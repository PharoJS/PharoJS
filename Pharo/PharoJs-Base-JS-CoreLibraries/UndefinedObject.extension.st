Extension { #name : #UndefinedObject }

{ #category : #'*PharoJs-Base-JS-CoreLibraries-converting' }
UndefinedObject >> asJsObjectUsing: converter [
	^self
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
UndefinedObject >> isPjProxyOrNil [
	^ false
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
UndefinedObject class >> javascriptPlaceholder [
	^ PjUndefinedObject
]
