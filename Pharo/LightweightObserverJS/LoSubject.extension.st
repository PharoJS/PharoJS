Extension { #name : #LoSubject }

{ #category : #'*LightweightObserverJS' }
LoSubject class >> javascriptPlaceholder [
	^LjSubject
]

{ #category : #'*LightweightObserverJS' }
LoSubject class >> selectorsWithExplicitOrigin [
	^self traitComposition selectors , self basicLocalSelectors
]
