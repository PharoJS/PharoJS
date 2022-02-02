"
I represent a null bridge client i.e. no interpreter is actually launched upon start
"
Class {
	#name : #PjNullBridgeClient,
	#superclass : #PjBridgeClient,
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #actions }
PjNullBridgeClient >> start [
	"start interpreter"

	^ self
]

{ #category : #actions }
PjNullBridgeClient >> stop [

	^ self
]
