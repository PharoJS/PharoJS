Class {
	#name : #PjJavascriptHelloWorldAppTest,
	#superclass : #PjHelloWorldAppTest,
	#category : #'PharoJsExamples-HelloWorld'
}

{ #category : #testing }
PjJavascriptHelloWorldAppTest >> currentApp [
	^self evalBlock: [ PjHelloWorldApp currentInstance ]
]
