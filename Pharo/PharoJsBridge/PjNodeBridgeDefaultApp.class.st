Class {
	#name : #PjNodeBridgeDefaultApp,
	#superclass : #PjNodeApplication,
	#category : #'PharoJsBridge-Client-Kernel'
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
