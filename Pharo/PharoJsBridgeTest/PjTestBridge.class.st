"
I am a bridge that doesn't actually communicate.

I can be used to test the incremental code generation that goes with normal bridge operations.
"
Class {
	#name : #PjTestBridge,
	#superclass : #PjBridge,
	#instVars : [
		'lastJavascript'
	],
	#category : #'PharoJsBridgeTest-Support'
}

{ #category : #public }
PjTestBridge >> evalJavascript: javaScriptString [
	^ lastJavascript := javaScriptString
]

{ #category : #accessing }
PjTestBridge >> lastJavascript [
	^ lastJavascript
]
