Extension { #name : #PjNodeApplication }

{ #category : #'*PharoJsExporter' }
PjNodeApplication class >> polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet [
	<pharoJsSkip>
	^ (super polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet) and: [
		aPolyfillClass nodePolyfill: aTranspiler.
		true
	]
]
