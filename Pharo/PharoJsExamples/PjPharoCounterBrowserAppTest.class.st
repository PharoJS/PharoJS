Class {
	#name : #PjPharoCounterBrowserAppTest,
	#superclass : #PjCounterBrowserAppTest,
	#category : #'PharoJsExamples-Counter'
}

{ #category : #testing }
PjPharoCounterBrowserAppTest >> app [
	PjCounterBrowserApp start.
	^PjCounterBrowserApp currentInstance.
]
