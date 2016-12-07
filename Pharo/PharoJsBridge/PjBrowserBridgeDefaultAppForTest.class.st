"
I am the default app loaded for bridge tests.
"
Class {
	#name : #PjBrowserBridgeDefaultAppForTest,
	#superclass : #PjBrowserApplication,
	#category : #'PharoJsBridge-Tests'
}

{ #category : #description }
PjBrowserBridgeDefaultAppForTest class >> appClasses [
	<pharoJsSkip>
	^ super appClasses, {  PjHTMLCollection. PjNodeList }
]

{ #category : #description }
PjBrowserBridgeDefaultAppForTest class >> appLaunchBlock [
	<pharoJsSkip>
	^[nil]
]
