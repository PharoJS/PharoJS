Extension { #name : #WBUnixWebBrowser }

{ #category : #'*PharoJsBridge' }
WBUnixWebBrowser class >> openBrowser: browserName on: anURLString inBackground: backgroundFlag [
	"Open the webbrowser on the given URL
	self openBrowser: 'Firefox' on: 'http://pharojs.org' inBackground: false.
	if the browserName is nil, open the default browser.
	self openBrowser: nil on: 'http://pharojs.org' inBackground: false.

	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	| openCommand |
	(browserName isNil or: [ backgroundFlag not ])
		ifTrue: [ ^ WebBrowser openOn: anURLString ].
	openCommand := '{1} {2} &'
		format:
			{browserName asLowercase.
			anURLString}.
	self system: openCommand
]

{ #category : #'*PharoJsBridge' }
WBUnixWebBrowser class >> openTerminalWithNodeOn: theFileName inFolder: anObject [
	self system: ('node {1} &' format: { theFileName })
]
