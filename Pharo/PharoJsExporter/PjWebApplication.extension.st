Extension { #name : #PjWebApplication }

{ #category : #'*PharoJsExporter-App' }
PjWebApplication class >> appHtmlUrlString [
	<pharoJsSkip>
	^'file:', self appFullHtmlFileName pathString asUrl asString
]

{ #category : #'*PharoJsExporter' }
PjWebApplication class >> polyfill: aPolyfillClass onStream: aStream unlessIn: aSet [
	<pharoJsSkip>
	^ (super polyfill: aPolyfillClass onStream: aStream unlessIn: aSet) and: [
		aPolyfillClass browserPolyfill: aStream.
		true
	]
]
