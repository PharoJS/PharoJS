Extension { #name : #Object }

{ #category : #'*PharoJsCoreLibraries-converting' }
Object >> asJsObject [
	^PjJsObjectBuilder convert: self
]

{ #category : #'*PharoJsCoreLibraries-converting' }
Object >> asJsObjectUsing: converter [
	| dict value |
	dict := Dictionary new.
	self class instVarNames do: [ : iv |
		value := self instVarNamed: iv.
		value ifNotNil: [ dict at: iv put: (converter convert: value)] ].
	^dict
]

{ #category : #'*PharoJsCoreLibraries' }
Object class >> javascriptPlaceholder [
	^PjObject
]

{ #category : #'*PharoJsCoreLibraries' }
Object >> setTimeout: aBlock afterMilliseconds: anInteger [
	anInteger milliSeconds wait.
	aBlock value
]
