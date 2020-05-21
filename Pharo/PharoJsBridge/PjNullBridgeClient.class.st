"
I represent a null bridge client i.e. no interpreter is actually launched upon start
"
Class {
	#name : #PjNullBridgeClient,
	#superclass : #PjBridgeClient,
	#category : #'PharoJsBridge-Client-Kernel'
}

{ #category : #activity }
PjNullBridgeClient >> start [
	"start interpreter"
	^self
]

{ #category : #activity }
PjNullBridgeClient >> stop [
	^self
]
