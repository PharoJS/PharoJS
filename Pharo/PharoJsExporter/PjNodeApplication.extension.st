Extension { #name : #PjNodeApplication }

{ #category : #'*PharoJsExporter' }
PjNodeApplication classSide >> polyfill: aPolyfillClass onStream: aStream [
	<pharoJsSkip>
	aPolyfillClass nodePolyfill: aStream
]
