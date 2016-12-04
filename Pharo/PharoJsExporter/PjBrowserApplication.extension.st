Extension { #name : #PjBrowserApplication }

{ #category : #'*PharoJsExporter' }
PjBrowserApplication classSide >> polyfill: aPolyfillClass onStream: aStream [
	<pharoJsSkip>
	aPolyfillClass browserPolyfill: aStream
]
