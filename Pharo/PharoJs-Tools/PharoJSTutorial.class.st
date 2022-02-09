"
I am a tutorial for some of the elements of PharoJS
"
Class {
	#name : #PharoJSTutorial,
	#superclass : #AbstractTutorial,
	#category : #'PharoJs-Tools-Tutorial'
}

{ #category : #lessons }
PharoJSTutorial >> pjPlayground [
	^ Lesson
		title: 'PharoJS Playground'
		lesson:
'"The Playground lets you explore the browser side of an app.

You can access it from the world menu or do the following:
"
	PjPlayground popUpMenu'
]

{ #category : #lessons }
PharoJSTutorial >> pjUseHelp [
	^ Lesson
		title: 'Use PharoJS Help instead'
		lesson:
'"It is very hard to do a tutorial, as most of the interactions are only available inside a PharoJS Playground.

So all the information is currently in the Help menu available from the World menu, or doing the following:"

	HelpBrowser openOn: PharoJsHelp'
]

{ #category : #tutorial }
PharoJSTutorial >> tutorial [
	^ #(
	pjUseHelp
	pjPlayground
	)
]
