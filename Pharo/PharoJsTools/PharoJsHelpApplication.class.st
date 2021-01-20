"
Help pages to describe Applications with PharoJS
"
Class {
	#name : #PharoJsHelpApplication,
	#superclass : #PharoJsHelp,
	#category : #'PharoJsTools-Help'
}

{ #category : #accessing }
PharoJsHelpApplication class >> bookName [ 
	^'Building Applications'
]

{ #category : #accessing }
PharoJsHelpApplication class >> key [
	^ self name
]

{ #category : #accessing }
PharoJsHelpApplication class >> pages [
	^ (self class methods collect: #selector thenSelect: [ : s | s beginsWith: #topic ]) sort,
		(self subclasses collect: #name)
]

{ #category : #pages }
PharoJsHelpApplication class >> topicApplication [
	<script: 'self edit: #topicApplication'>
	^HelpTopic
		title: 'Introduction'
		contents: 
'To develop an application, whether a Single Page Application (SPA)  or simply code to support a conventional web page, create a class that is a subclass of PjApplication - usually a subclass of PjBrowserApplication or PjNodeApplication.

The subclasses define appropriate Javascript values to be referenced by proxies when code is running on Pharo.
These are defined by shared pool dictionaries.!' readStream nextChunkText
]

{ #category : #pages }
PharoJsHelpApplication class >> topicGlobalsAndPolyfills [
	"This method was automatically generated."
	<script: 'self edit: #topicGlobalsAndPolyfills'>
	^HelpTopic
		title: 'Globals and Polyfills'
		contents: 
'When code is running on Pharo, references to Javascript values such as the DOM need to be in scope.
When code is running on Pharo or a Javascript engine, polyfills are used to sew together the application with other libraries.

Both of these requirements are achieved by using Shared Pool Dictionaries.
!' readStream nextChunkText
]
