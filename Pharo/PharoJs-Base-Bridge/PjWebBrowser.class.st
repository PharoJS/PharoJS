Class {
	#name : 'PjWebBrowser',
	#superclass : 'PjOsPlatformVisitor',
	#instVars : [
		'browserName',
		'isBackground'
	],
	#category : 'PharoJs-Base-Bridge-Client-OsPlatform-API',
	#package : 'PharoJs-Base-Bridge',
	#tag : 'Client-OsPlatform-API'
}

{ #category : 'utility' }
PjWebBrowser class >> openBrowser: browserName on: anURLString inBackground: backgroundFlag [
	"Open the webbrowser on the given URL
	self openBrowser: 'Firefox' on: 'http://pharojs.org' inBackground: false.
	if the browserName is nil, open the default browser.
	self openBrowser: nil on: 'http://pharojs.org' inBackground: false.

	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	self new
		openBrowser: browserName 
		on: anURLString 
		inBackground: backgroundFlag
]

{ #category : 'utility' }
PjWebBrowser class >> openInBackgroundUrl: anURLString [

	^ self openOn: anURLString inBackground: true
]

{ #category : 'utility' }
PjWebBrowser class >> openOn: anURLString inBackground: backgroundFlag [
	"Open the webbrowser on the given URL
	self openOn: 'http://pharojs.org' inBackground: false.
	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	self openBrowser: nil on: anURLString inBackground: backgroundFlag
]

{ #category : 'utility' }
PjWebBrowser >> openBrowser: aBrowserName on: aURLString inBackground: backgroundFlag [ 
	browserName := aBrowserName.
	self url: aURLString.
	isBackground := backgroundFlag.
	self visit
	
]

{ #category : 'visiting' }
PjWebBrowser >> visitMacOS: aPlatform [

	"Open the webbrowser on the given URL
	self openBrowser: 'Firefox' on: 'http://pharojs.org' inBackground: false.
	if the browserName is nil, open the default browser.
	self openBrowser: nil on: 'http://pharojs.org' inBackground: false.

	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	| openScriptPath backgroundCommand browserCommandName command |
	backgroundCommand := isBackground 
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
			           << url;
						<<$";
			           space;
			           << browserCommandName;
			           space;
			           << backgroundCommand ].
	self system: command
]

{ #category : 'visiting' }
PjWebBrowser >> visitUnix: aPlatform [

	| openCommand |
	(browserName isNil or: [ isBackground not ])
		ifTrue: [ ^ super visitUnix: aPlatform ].
	openCommand := '{1} {2} &'
		format:
			{browserName asLowercase.
			url}.
	self system: openCommand
]

{ #category : 'visiting' }
PjWebBrowser >> visitWindows: aPlatform [

	"Open the webbrowser on the given URL
	self openBrowser: 'Firefox' on: 'http://pharojs.org' inBackground: false.
	if the browserName is nil, open the default browser.
	self openBrowser: nil on: 'http://pharojs.org' inBackground: false.

	The backgroundFlag is true when the window of the browser should open behind the Pharo window.
	"

	(browserName isNil or: [ isBackground not ]) ifTrue: [ 
		^ super visitWindows: aPlatform].
	^ self
		  shellExecute: 'open'
		  file: browserName asLowercase
		  parameters: url
		  directory: ''
		  show: 5 "SW_SHOW"
]
