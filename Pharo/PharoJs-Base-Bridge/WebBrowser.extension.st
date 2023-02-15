Extension { #name : #WebBrowser }

{ #category : #'*PharoJs-Base-Bridge' }
WebBrowser class >> openBrowser: browserName on: anURLString inBackground: backgroundFlag [
	"Open the webbrowser on the given URL
	self openBrowser: 'Firefox' on: 'http://pharojs.org' inBackground: false.
	if the browserName is nil, open the default browser.
	self openBrowser: nil on: 'http://pharojs.org' inBackground: false.

	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"
	^ self webbrowserClassForPlatform
		openBrowser: browserName
		on: anURLString
		inBackground: backgroundFlag
]

{ #category : #'*PharoJs-Base-Bridge' }
WebBrowser class >> openInBackgroundUrl: anURLString [

	^ self openOn: anURLString inBackground: true
]

{ #category : #'*PharoJs-Base-Bridge' }
WebBrowser class >> openOn: anURLString inBackground: backgroundFlag [
	"Open the webbrowser on the given URL
	self openOn: 'http://pharojs.org' inBackground: false.
	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	self openBrowser: nil on: anURLString inBackground: backgroundFlag
]

{ #category : #'*PharoJs-Base-Bridge' }
WebBrowser class >> openTerminalWithNodeOn: theFileName inFolder: theFolder [
	"Open a terminal with node running on the given file"

	^ self webbrowserClassForPlatform
		openTerminalWithNodeOn: theFileName
		inFolder: theFolder
]
