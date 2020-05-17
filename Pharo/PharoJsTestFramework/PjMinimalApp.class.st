Class {
	#name : #PjMinimalApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'data'
	],
	#category : #'PharoJsTestFramework-Test'
}

{ #category : #accessing }
PjMinimalApp class >> data: d [
	^ self new data: d
]

{ #category : #comparing }
PjMinimalApp >> <= other [
	^ data <= other data
]

{ #category : #comparing }
PjMinimalApp >> data [
	^ data
]

{ #category : #comparing }
PjMinimalApp >> data: d [
	data := d
]
