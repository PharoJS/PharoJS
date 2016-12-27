Extension { #name : #PjBrowserApplication }

{ #category : #'*PharoJsExporter' }
PjBrowserApplication classSide >> polyfill: aPolyfillClass onStream: aStream unlessIn: aSet [
	<pharoJsSkip>
	^ (super polyfill: aPolyfillClass onStream: aStream unlessIn: aSet) and: [
		aPolyfillClass browserPolyfill: aStream.
		true
	]
]
