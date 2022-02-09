Extension { #name : #Object }

{ #category : #'*PharoJs-Base-JS-CoreLibraries-converting' }
Object >> asJsObject [
	^PjJsObjectBuilder convert: self
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries-converting' }
Object >> asJsObjectUsing: converter [
	| dict value |
	dict := Dictionary new.
	self class instVarNames do: [ : iv |
		value := self instVarNamed: iv.
		value ifNotNil: [ dict at: iv put: (converter convert: value)] ].
	^dict
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
Object >> isPjProxyOrNil [
	^ false
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
Object class >> javascriptPlaceholder [
	^PjObject
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
Object >> setTimeout: aBlock afterMilliseconds: anInteger [
	[anInteger milliSeconds wait.
	aBlock value] fork
]
