Class {
	#name : #PjNodeBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#category : #'PharoJsBridge-Client-Kernel'
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
PjNodeBridgeClient >> start [
	super start.
	self runNodeOn: self fileName fullName inFolder: self appFolder fullName
]
