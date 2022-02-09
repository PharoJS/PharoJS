Extension { #name : #PjNodeApplication }

{ #category : #'*PharoJs-Base-Exporter' }
PjNodeApplication class >> polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet [
	<pharoJsSkip>
	
	^ (super polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet) and: [
		aPolyfillClass nodePolyfill: aTranspiler.
		true
	]
]
