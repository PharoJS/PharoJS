"
I am a bridge client for file based applications running on a web browser. The actual browser is defined by the platform I am bound to.

"
Class {
	#name : #PjPlatformBoundFileBasedBrowserBridgeClient,
	#superclass : #PjFileBasedBrowserBridgeClient,
	#instVars : [
		'platform'
	],
	#category : #'PharoJsTestFramework-Clients'
}

{ #category : #'instance creation' }
PjPlatformBoundFileBasedBrowserBridgeClient class >> newFor: platform [
	^self new
		platform: platform;
		yourself
]

{ #category : #accessing }
PjPlatformBoundFileBasedBrowserBridgeClient >> browserName [
	^self platform browserName
]

{ #category : #activity }
PjPlatformBoundFileBasedBrowserBridgeClient >> openWebBrowserOn: appHtmlFileUrlString [
	WebBrowser openBrowser: self browserName on: appHtmlFileUrlString inBackground: true 
]

{ #category : #accessing }
PjPlatformBoundFileBasedBrowserBridgeClient >> platform [
	^ platform
]

{ #category : #accessing }
PjPlatformBoundFileBasedBrowserBridgeClient >> platform: anObject [
	platform := anObject
]
