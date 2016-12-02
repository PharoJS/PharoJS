Class {
	#name : #PjJavascriptCounterBrowserAppTest,
	#superclass : #PjCounterBrowserAppTest,
	#category : #'PharoJsExamples-Counter'
}

{ #category : #'suite parameters' }
PjJavascriptCounterBrowserAppTest class >> targetPlatforms [
	^{PjSafari . PjGoogleChrome. PjFireFox. }
]

{ #category : #testing }
PjJavascriptCounterBrowserAppTest >> app [
	^ self evalBlock: [PjCounterBrowserApp currentInstance]
]
