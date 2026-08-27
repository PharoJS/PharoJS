"
We inherit from WebBrowser to access Windows shell method #shellExecute:file:parameters:directory:show: 
"
Class {
	#name : 'PjOsPlatformVisitor',
	#superclass : 'WebBrowser',
	#category : 'PharoJs-Base-Bridge-Client-OsPlatform-API',
	#package : 'PharoJs-Base-Bridge',
	#tag : 'Client-OsPlatform-API'
}

{ #category : 'visiting' }
PjOsPlatformVisitor >> system: commandString [
	LibC system: commandString
]
