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
PjNodeBridgeClient >> runNodeOn: aFileName [
	WebBrowser openTerminalWithNodeOn: aFileName
]

{ #category : #activity }
PjNodeBridgeClient >> start [
	super start.
	self runNodeOn: self fileName fullName
]

{ #category : #accessing }
PjNodeBridgeClient >> title [
	^ 'Node Bridge'
]
