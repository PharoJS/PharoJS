Extension { #name : #TClassDescription }

{ #category : #'*PharoJsCoreLibraries' }
TClassDescription >> selectorsInProtocols: protocols [
	<pharoJsSkip>
	| selectors |
	selectors := Set new.
	protocols do: [ : protocol |
		selectors addAll: (self selectorsInProtocol: protocol)].
	^selectors
]

{ #category : #'*PharoJsCoreLibraries' }
TClassDescription >> selectorsInProtocols: protocols exclude: excludedSelectors [
	<pharoJsSkip>
	| selectors |
	selectors := self selectorsInProtocols: protocols. 
	^selectors copyWithoutAll: excludedSelectors
]
