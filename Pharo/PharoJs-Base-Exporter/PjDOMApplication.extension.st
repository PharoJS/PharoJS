Extension { #name : #PjDOMApplication }

{ #category : #'*PharoJs-Base-Exporter-App' }
PjDOMApplication class >> appFullHtmlFileName [
	<pharoJsSkip>
	
	^self appFullHtmlFolderPath / self appHtmlFileName
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjDOMApplication class >> appFullHtmlFolderPath [

	<pharoJsSkip>
	self appHtmlSubFolder ifNil: [ ^ self appFolder ].
	^ self ensureSubFolder: self appHtmlSubFolder in: self appFolder
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjDOMApplication class >> appFullJsFolderPath [

	<pharoJsSkip>
	self appJsSubFolder ifNil: [^self appFullHtmlFolderPath].
	^self ensureSubFolder: self appJsSubFolder in: self appFullHtmlFolderPath
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjDOMApplication class >> appHtmlFileName [
	<pharoJsSkip>
	^ 'index.html'
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjDOMApplication class >> appHtmlSubFolder [
	<pharoJsSkip>
	"Subclass might return, e.g. 'www' if you want the html to be in the www sub-directory. 
	Useful, when you need to access the app/project folder that is different from the JS folder as with PhoneGap."
	^ nil
]

{ #category : #'*PharoJs-Base-Exporter' }
PjDOMApplication class >> polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet [
	<pharoJsSkip>
	^ (super polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet) and: [
		aPolyfillClass domPolyfill: aTranspiler.
		true
	]
]
