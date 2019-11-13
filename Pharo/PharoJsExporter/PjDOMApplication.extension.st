Extension { #name : #PjDOMApplication }

{ #category : #'*PharoJsExporter-App' }
PjDOMApplication class >> appFullHtmlFileName [
	<pharoJsSkip>
	^self appFullHtmlFolderPath / self appHtmlFileName

]

{ #category : #'*PharoJsExporter-App' }
PjDOMApplication class >> appFullHtmlFolderPath [
	<pharoJsSkip>
	self appHtmlSubFolder ifNotNil: [: subfolder|
		^self appFolder / subfolder 
	].
	^self appFolder

]

{ #category : #'*PharoJsExporter-App' }
PjDOMApplication class >> appFullJsFolderPath [
	<pharoJsSkip>
	self appJsSubFolder ifNotNil: [: subfolder|
		^self appFullHtmlFolderPath / subfolder 
	].
	^self appFullHtmlFolderPath

]

{ #category : #'*PharoJsExporter-App' }
PjDOMApplication class >> appHtmlFileName [
	<pharoJsSkip>
	^ 'index.html'
]

{ #category : #'*PharoJsExporter-App' }
PjDOMApplication class >> appHtmlSubFolder [
	<pharoJsSkip>
	"Subclass might return, e.g. 'www' if you want the html to be in the www sub-directory. 
	Useful, when you need to access the app/project folder that is different from the JS folder as with PhoneGap."
	^ nil
]

{ #category : #'*PharoJsExporter' }
PjDOMApplication class >> polyfill: aPolyfillClass onStream: aStream unlessIn: aSet [
	<pharoJsSkip>
	^ (super polyfill: aPolyfillClass onStream: aStream unlessIn: aSet) and: [
		aPolyfillClass domPolyfill: aStream.
		true
	]
]
