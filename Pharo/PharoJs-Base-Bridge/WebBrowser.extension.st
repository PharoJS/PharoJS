Extension { #name : 'WebBrowser' }

{ #category : '*PharoJs-Base-Bridge' }
WebBrowser class >> openOn: anURLString inBackground: backgroundFlag [
	"Open the webbrowser on the given URL
	self openOn: 'http://pharojs.org' inBackground: false.
	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	self openOn: anURLString 
]

{ #category : '*PharoJs-Base-Bridge' }
WebBrowser class >> openTerminalWithNodeOn: theFileName inFolder: theFolder [
	"Open a terminal with node running on the given file"
	self shouldBeImplemented.
	^ self webbrowserClassForPlatform
		openTerminalWithNodeOn: theFileName
		inFolder: theFolder
]
