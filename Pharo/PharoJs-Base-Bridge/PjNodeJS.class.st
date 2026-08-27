Class {
	#name : 'PjNodeJS',
	#superclass : 'PjOsPlatformVisitor',
	#instVars : [
		'theFolder',
		'theFileName'
	],
	#category : 'PharoJs-Base-Bridge-Client-OsPlatform-API',
	#package : 'PharoJs-Base-Bridge',
	#tag : 'Client-OsPlatform-API'
}

{ #category : 'utility' }
PjNodeJS class >> run: aFileName inFolder: aFolder [
	self new
		run: aFileName inFolder: aFolder
]

{ #category : 'visiting' }
PjNodeJS >> run: aFileName inFolder: aFolder [
	"Open a terminal with node running on the given file"

	theFileName := aFileName.
	theFolder := aFolder.
	self visit
]

{ #category : 'visiting' }
PjNodeJS >> visitMacOS: aPlatform [

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

{ #category : 'visiting' }
PjNodeJS >> visitUnix: aPlatform [

	self system: ('node {1} &' format: { theFileName })
]

{ #category : 'visiting' }
PjNodeJS >> visitWindows: aPlatform [

	self
		shellExecute: 'open'
		file: 'node'
		parameters: '"' , theFileName , '"'
		directory: ''
		show: 5 "SW_SHOW"
]
