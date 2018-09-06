Extension { #name : #PjWebApplication }

{ #category : #'*PharoJsExporter-App' }
PjWebApplication classSide >> appHtmlUrlString [
	<pharoJsSkip>
	^'file:', self appFullHtmlFileName pathString asUrl asString
]

{ #category : #'*PharoJsExporter' }
PjWebApplication classSide >> polyfill: aPolyfillClass onStream: aStream unlessIn: aSet [
	<pharoJsSkip>
	^ (super polyfill: aPolyfillClass onStream: aStream unlessIn: aSet) and: [
		aPolyfillClass browserPolyfill: aStream.
		true
	]
]
