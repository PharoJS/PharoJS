"
I am the bridge client for applications to run on NodeJS
"
Class {
	#name : #PjNodeBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #'initialization-release' }
PjNodeBridgeClient >> defaultAppClass [
	^PjNodeBridgeDefaultApp
]

{ #category : #activity }
PjNodeBridgeClient >> runNodeOn: aFileName inFolder: aFolder [
	WebBrowser openTerminalWithNodeOn: aFileName inFolder: aFolder
]

{ #category : #activity }
PjNodeBridgeClient >> startJsInterpreter [
	self
		runNodeOn: self fileName fullName
		inFolder: self appFolder fullName
]
