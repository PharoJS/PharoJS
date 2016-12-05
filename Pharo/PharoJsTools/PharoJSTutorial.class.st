"
I am a tutorial for some of the elements of PharoJS
"
Class {
	#name : #PharoJSTutorial,
	#superclass : #AbstractTutorial,
	#category : #'PharoJsTools-Tutorial'
}

{ #category : #lessons }
PharoJSTutorial >> pjExporter [
	^ Lesson
		title: 'PharoJS Exporter'
		lesson:
'"To generate javascript code from an application, simply"
	PjDrawRectangleUseDnuApp exportApp
"and an index.js file will be produced in the directory specified
for the application.

The file name and many other parameters are controlled by class-side
methods of the application."'
]

{ #category : #lessons }
PharoJSTutorial >> pjInspector [
	^ Lesson
		title: 'PharoJS Inspector'
		lesson:
'"The Inspector understands PjProxy values and communicates with the
relevant Javascript engine (browser or NodeJS) to examine programmatic values.

For example by selecting and Cmd-I the following:"
	document fonts
"you would get an inspector showing all the fields of the object
-- if document were defined in this scope, which it''s not.

However this works fine in a PharoJS Playground, or in
methods of a class that specify the poolDictionary PjDomGlobals"'
]

{ #category : #lessons }
PharoJSTutorial >> pjPlayground [
	^ Lesson
		title: 'PharoJS Playground'
		lesson:
'"The Playground lets you explore the browser side of an app.

"'
]

{ #category : #tutorial }
PharoJSTutorial >> tutorial [
	^ #(
	#pjPlayground
	#pjInspector
	#pjExporter
	)
]
