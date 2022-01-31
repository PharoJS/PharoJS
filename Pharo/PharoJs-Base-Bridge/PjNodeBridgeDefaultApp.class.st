"
I am a trivial client for NodeJS bridge for exploration.
"
Class {
	#name : #PjNodeBridgeDefaultApp,
	#superclass : #PjNodeApplication,
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #description }
PjNodeBridgeDefaultApp class >> appClasses [
	<pharoJsSkip>
	^#()
]

{ #category : #'start-stop application' }
PjNodeBridgeDefaultApp class >> appLaunchBlock [
	<pharoJsSkip>
	^[ nil ]
]
