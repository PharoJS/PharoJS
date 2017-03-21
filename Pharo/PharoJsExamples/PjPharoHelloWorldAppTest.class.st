Class {
	#name : #PjPharoHelloWorldAppTest,
	#superclass : #PjHelloWorldAppTest,
	#category : #'PharoJsExamples-HelloWorld'
}

{ #category : #testing }
PjPharoHelloWorldAppTest >> currentApp [
	^PjHelloWorldApp currentInstance
]
