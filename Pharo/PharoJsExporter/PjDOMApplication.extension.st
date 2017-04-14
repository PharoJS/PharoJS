Extension { #name : #PjDOMApplication }

{ #category : #'*PharoJsExporter-App' }
PjDOMApplication classSide >> appFullHtmlFileName [
	<pharoJsSkip>
	^self appFullHtmlFolderPath / self appHtmlFileName

]

{ #category : #'*PharoJsExporter-App' }
PjDOMApplication classSide >> appFullHtmlFolderPath [
	<pharoJsSkip>
	self appHtmlSubFolder ifNotNil: [: subfolder|
		^self appFolder / subfolder 
	].
	^self appFolder

]

{ #category : #'*PharoJsExporter-App' }
PjDOMApplication classSide >> appHtmlFileName [
	<pharoJsSkip>
	^ 'index.html'
]

{ #category : #'*PharoJsExporter-App' }
PjDOMApplication classSide >> appHtmlSubFolder [
	<pharoJsSkip>
	"Subclass might return, e.g. 'www' if you want the html to be in the www sub-directory. 
	Useful, when you need to access the app/project folder that is different from the JS folder as with PhoneGap."
	^ nil
]

{ #category : #'*PharoJsExporter' }
PjDOMApplication classSide >> polyfill: aPolyfillClass onStream: aStream unlessIn: aSet [
	<pharoJsSkip>
	^ (super polyfill: aPolyfillClass onStream: aStream unlessIn: aSet) and: [
		aPolyfillClass domPolyfill: aStream.
		true
	]
]
