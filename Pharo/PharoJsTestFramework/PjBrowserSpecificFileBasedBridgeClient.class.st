Class {
	#name : #PjBrowserSpecificFileBasedBridgeClient,
	#superclass : #PjFileBasedBrowserBridgeClient,
	#instVars : [
		'platform'
	],
	#category : #'PharoJsTestFramework-Clients'
}

{ #category : #'instance creation' }
PjBrowserSpecificFileBasedBridgeClient class >> newFor: platform [
	^self new
		platform: platform;
		yourself
]

{ #category : #accessing }
PjBrowserSpecificFileBasedBridgeClient >> browserName [
	^self platform browserName
]

{ #category : #activity }
PjBrowserSpecificFileBasedBridgeClient >> openWebBrowserOn: appHtmlFileUrlString [
	WebBrowser openBrowser: self browserName on: appHtmlFileUrlString inBackground: true 
]

{ #category : #accessing }
PjBrowserSpecificFileBasedBridgeClient >> platform [
	^ platform
]

{ #category : #accessing }
PjBrowserSpecificFileBasedBridgeClient >> platform: anObject [
	platform := anObject
]
