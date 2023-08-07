Extension { #name : #WBMacWebBrowser }

{ #category : #'*PharoJs-Base-Bridge' }
WBMacWebBrowser class >> openBrowser: browserName on: urlString inBackground: backgroundFlag [

	"Open the webbrowser on the given URL
	self openBrowser: 'Firefox' on: 'http://pharojs.org' inBackground: false.
	if the browserName is nil, open the default browser.
	self openBrowser: nil on: 'http://pharojs.org' inBackground: false.

	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	| openScriptPath backgroundCommand browserCommandName command |
	backgroundCommand := backgroundFlag
		                     ifTrue: [ 'background' ]
		                     ifFalse: [ '' ].
	browserCommandName := browserName ifNil: [ 'default' ].
	openScriptPath := PjApplication repositoryFolder / 'Tools' / 'MacOsX'
	                  / 'openUrl'.
	command := String streamContents: [ :str | 
		           str
			           << openScriptPath pathString;
			           space;
						<<$";
			           << urlString;
						<<$";
			           space;
			           << browserCommandName;
			           space;
			           << backgroundCommand ].
	self system: command
]

{ #category : #'*PharoJs-Base-Bridge' }
WBMacWebBrowser class >> openTerminalWithNodeOn: theFileName inFolder: theFolder [

	| cd |
	cd := theFolder ifNil: [ '' ] ifNotNil: [ 'cd ' , theFolder , '; ' ].
	self system: 'osascript -e ''
  tell application "Terminal"
    activate
    set newTab to do script("' , cd , 'exec node ' , theFileName
		, '")
    set current settings of selected tab of window 1 to settings set "PharoNode"
  end tell'''
]
