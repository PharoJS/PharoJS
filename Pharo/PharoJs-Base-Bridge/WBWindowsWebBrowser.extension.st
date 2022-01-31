Extension { #name : #WBWindowsWebBrowser }

{ #category : #'*PharoJs-Base-Bridge' }
WBWindowsWebBrowser class >> openBrowser: browserName on: anURLString inBackground: backgroundFlag [
	"Open the webbrowser on the given URL
	self openBrowser: 'Firefox' on: 'http://pharojs.org' inBackground: false.
	if the browserName is nil, open the default browser.
	self openBrowser: nil on: 'http://pharojs.org' inBackground: false.

	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	(browserName isNil or: [ backgroundFlag not ])
		ifTrue: [ ^ WebBrowser openOn: anURLString  ].
	^ self
		shellExecute: 'open'
		file: browserName asLowercase
		parameters: anURLString
		directory: ''
		show: 5	"SW_SHOW"
]

{ #category : #'*PharoJs-Base-Bridge' }
WBWindowsWebBrowser class >> openTerminalWithNodeOn: theFileName inFolder: anObject [
	self shellExecute: 'open' file: 'node' parameters: theFileName directory: '' show: 5 "SW_SHOW"
]
