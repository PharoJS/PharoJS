"
I am the bridge client for applications to run on NodeJS
"
Class {
	#name : #PjNodeBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #'accessing - defaults' }
PjNodeBridgeClient >> defaultAppClass [

	^ PjMinimalNodeApplication 
]

{ #category : #actions }
PjNodeBridgeClient >> runNodeOn: aFileName inFolder: aFolder [

	WebBrowser openTerminalWithNodeOn: aFileName inFolder: aFolder
]

{ #category : #actions }
PjNodeBridgeClient >> startJsInterpreter [

	self
		runNodeOn: self fileName fullName
		inFolder: self appFolder fullName
]
