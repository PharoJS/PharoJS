Extension { #name : #WBWindowsWebBrowser }

{ #category : #'*PharoJsBridge' }
WBWindowsWebBrowser class >> openBrowser: browserName on: anURLString inBackground: backgroundFlag [
	"Open the webbrowser on the given URL
	self openBrowser: 'Firefox' on: 'http://pharojs.org' inBackground: false.
	if the browserName is nil, open the default browser.
	self openBrowser: nil on: 'http://pharojs.org' inBackground: false.

	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	self flag: #todo.
	(browserName or: [ backgroundFlag not ])
		ifNil: [ ^ self
				error: 'TODO: handle when the browserName is nil or when backgroundFlag is false' ].
	^ self
		shellExecute: 'open'
		file: browserName asLowercase
		parameters: anURLString
		directory: ''
		show: 5	"SW_SHOW"
]

{ #category : #'*PharoJsBridge' }
WBWindowsWebBrowser class >> openTerminalWithNodeOn: theFileName [
	self shellExecute: 'open' file: 'node' parameters: theFileName directory: '' show: 5 "SW_SHOW"
]
