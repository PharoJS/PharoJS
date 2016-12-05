Class {
	#name : #PjPresentation,
	#superclass : #GLMPharoScriptPresentation,
	#instVars : [
		'playground'
	],
	#category : #'PharoJsTools-Playground'
}

{ #category : #'instance creation' }
PjPresentation class >> onPlayground: aPlayground [
	^ self new playground: aPlayground;yourself
]

{ #category : #accessing }
PjPresentation >> playground [
	^ playground
]

{ #category : #accessing }
PjPresentation >> playground: anObject [
	playground := anObject
]

{ #category : #rendering }
PjPresentation >> renderGlamorouslyOn: aRenderer [
	"we delegate to the arrangement to dispatch the type of the actual arrangement of the nested presentations"
	self registerAnnouncements.
	^ aRenderer pjRenderOn: self
]
