Class {
	#name : #PjAppForPathTest,
	#superclass : #PjFileBasedWebApp,
	#classInstVars : [
		'appJsSubFolder',
		'appHtmlSubFolder'
	],
	#category : #'PharoJs-Base-Exporter-Tests-Support'
}

{ #category : #accessing }
PjAppForPathTest class >> appFolder [
	^appFolder
]

{ #category : #accessing }
PjAppForPathTest class >> appHtmlSubFolder [
	^appHtmlSubFolder
]

{ #category : #accessing }
PjAppForPathTest class >> appHtmlSubFolder: anObject [
	appHtmlSubFolder := anObject
]

{ #category : #accessing }
PjAppForPathTest class >> appJsSubFolder [
	^appJsSubFolder
]

{ #category : #accessing }
PjAppForPathTest class >> appJsSubFolder: anObject [
	appJsSubFolder := anObject
]
