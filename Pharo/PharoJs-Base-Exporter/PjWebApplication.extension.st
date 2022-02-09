Extension { #name : #PjWebApplication }

{ #category : #'*PharoJs-Base-Exporter-App' }
PjWebApplication class >> appHtmlUrlString [
	<pharoJsSkip>
	
	^ 'file:' , self appFullHtmlFileName pathString asUrl asString
]

{ #category : #'*PharoJs-Base-Exporter' }
PjWebApplication class >> polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet [
	<pharoJsSkip>
	
	^ (super
		   polyfill: aPolyfillClass
		   withTranspiler: aTranspiler
		   unlessIn: aSet) and: [ 
		  aPolyfillClass browserPolyfill: aTranspiler.
		  true ]
]
