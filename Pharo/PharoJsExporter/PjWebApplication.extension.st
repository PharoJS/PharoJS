Extension { #name : #PjWebApplication }

{ #category : #'*PharoJsExporter-App' }
PjWebApplication class >> appHtmlUrlString [
	<pharoJsSkip>
	^'file:', self appFullHtmlFileName pathString asUrl asString
]

{ #category : #'*PharoJsExporter' }
PjWebApplication class >> polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet [
	<pharoJsSkip>
	^ (super polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet) and: [
		aPolyfillClass browserPolyfill: aTranspiler.
		true
	]
]
