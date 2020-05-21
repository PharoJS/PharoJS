Extension { #name : #WBMacWebBrowser }

{ #category : #'*PharoJsBridge' }
WBMacWebBrowser class >> openBrowser: browserName on: anURLString inBackground: backgroundFlag [
	"Open the webbrowser on the given URL
	self openBrowser: 'Firefox' on: 'http://pharojs.org' inBackground: false.
	if the browserName is nil, open the default browser.
	self openBrowser: nil on: 'http://pharojs.org' inBackground: false.

	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	| openCommand backgroundCommandFlag browserCommandFlag |
	backgroundCommandFlag := backgroundFlag
		ifTrue: [ ' -g ' ]
		ifFalse: [ '' ].
	browserCommandFlag := browserName ifNil: [ '' ] ifNotNil: [ ' -a "{2}" ' ].
	openCommand := 'open "{1}" ' , backgroundCommandFlag , browserCommandFlag
		format:
			{anURLString.
			browserName}.
	self system: openCommand
]

{ #category : #'*PharoJsBridge' }
WBMacWebBrowser class >> openTerminalWithNodeOn: theFileName inFolder: theFolder [
	| cd |
	cd := theFolder ifNil: [ '' ] ifNotNil: [ 'cd ',theFolder,'; ' ].
	self system: 'osascript -e ''
  tell application "Terminal"
    activate
    set newTab to do script("',cd,'exec node ',theFileName,'")
    set current settings of selected tab of window 1 to settings set "PharoNode"
  end tell'''
]
