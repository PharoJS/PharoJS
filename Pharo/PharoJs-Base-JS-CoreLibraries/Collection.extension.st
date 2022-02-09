Extension { #name : #Collection }

{ #category : #'*PharoJs-Base-JS-CoreLibraries-converting' }
Collection >> asJsObjectUsing: converter [
	^self collect: [ : each | each  asJsObjectUsing: converter]
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
Collection class >> javascriptPlaceholder [
	^PjCollection
]
