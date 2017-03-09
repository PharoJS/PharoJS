Class {
	#name : #PjJavascriptCounterBrowserAppTest,
	#superclass : #PjCounterBrowserAppTest,
	#category : #'PharoJsExamples-Counter'
}

{ #category : #testing }
PjJavascriptCounterBrowserAppTest >> currentApp [
	^ self evalBlock: [PjCounterBrowserApp currentInstance]
]
