"
Hierarchical help for PharoJS
"
Class {
	#name : #PharoJsHelp,
	#superclass : #CustomHelp,
	#category : #'PharoJsTools-Help'
}

{ #category : #accessing }
PharoJsHelp class >> bookName [ 
	^'PharoJS'
]

{ #category : #accessing }
PharoJsHelp class >> key [
	^ self name
]

{ #category : #accessing }
PharoJsHelp class >> pages [
	^ (self class methods collect: #selector thenSelect: [ : s | s beginsWith: #topic ]) sort,
		(self subclasses collect: #name)
]

{ #category : #documentation }
PharoJsHelp class >> topic0Overview [
	"This method was automatically generated."
	<script: 'self edit: #topic0Overview'>
	^HelpTopic
		title: 'Introduction'
		contents: 
'PharoJS allows you to develop code for the web - from the comfort of your Pharo environment.

PharoJS can support this several ways:
1) PharoJS can export an application to a file ready to be deployed
2) PharoJS can interactively run an application in a browser with interaction via a PharoJS playground
3) PharoJS can run an application within Pharo that interacts directly with the object in a Javascript engine (web browser of Node)
!' readStream nextChunkText
]

{ #category : #documentation }
PharoJsHelp class >> topicPjInspector [
	<script: 'self edit: #topicPjInspector'>
	^ HelpTopic
		title: 'Inspector'
		contents:
'The Inspector understands PjProxy values and communicates with the
relevant Javascript engine (browser or NodeJS) to examine programmatic values.

For example by selecting and Cmd-I the following:
	document fonts
you would get an inspector showing all the fields of the object
-- if document were defined in this scope, which it''s not.

However this works fine in a PharoJS Playground, or in
methods of a class that specify the poolDictionary PjDomGlobals'
]

{ #category : #documentation }
PharoJsHelp class >> topicPjPlayground [
	<script: 'self edit: #topicPjPlayground'>
	^ HelpTopic
		title: 'Playground'
		contents:
'The PharoJS Playground lets you explore the browser side of an app.

Access the PharoJS Playground from the world menu which will allow you to launch a playground for any app that you have in the image.

You can launch the app on Pharo, which means that all of your Pharo Smalltalk code will run in the Pharo image, but you can access the DOM, Javascript libraries, and other Javascript values via proxies visible as globals in the playground.

You can also launch the app on the Javascript engine (Web browser or Node). In this case, the code is all translated to Javascript and installed in the JSE.  In addition to the proxies mentioned above, the application and other installed classes running on the JSE are accessible via proxies.
'
]
