Extension { #name : #PjBrowserApplication }

{ #category : #'*PharoJsExporter-App' }
PjBrowserApplication classSide >> appHtmlUrlString [
	<pharoJsSkip>
	^'file:', self appFullHtmlFileName pathString asUrl asString
]

{ #category : #'*PharoJsExporter' }
PjBrowserApplication classSide >> polyfill: aPolyfillClass onStream: aStream unlessIn: aSet [
	<pharoJsSkip>
	^ (super polyfill: aPolyfillClass onStream: aStream unlessIn: aSet) and: [
		aPolyfillClass browserPolyfill: aStream.
		true
	]
]
