Extension { #name : #ClassDescription }

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
ClassDescription >> selectorsInProtocols: protocols [
	<pharoJsSkip>
	| selectors |
	selectors := Set new.
	protocols do: [ : protocol |
		selectors addAll: (self selectorsInProtocol: protocol)].
	^selectors
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
ClassDescription >> selectorsInProtocols: protocols exclude: excludedSelectors [
	<pharoJsSkip>
	| selectors |
	selectors := self selectorsInProtocols: protocols. 
	^selectors copyWithoutAll: excludedSelectors
]
