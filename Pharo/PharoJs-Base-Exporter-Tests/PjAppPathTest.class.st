Class {
	#name : #PjAppPathTest,
	#superclass : #TestCase,
	#instVars : [
		'appClass'
	],
	#category : #'PharoJs-Base-Exporter-Tests-Tests'
}

{ #category : #running }
PjAppPathTest >> resetAppClass [

	appClass appHtmlSubFolder: nil.
	appClass appJsSubFolder: nil.
	appClass defaultAppFolderPath deleteAll.
	appClass appFolder: appClass defaultAppFolder 
]

{ #category : #running }
PjAppPathTest >> setUp [

	super setUp.
	appClass := PjAppForPathTest.
	self resetAppClass
]

{ #category : #running }
PjAppPathTest >> tearDown [
	super tearDown.
	self resetAppClass
]

{ #category : #running }
PjAppPathTest >> testDefaultAppFolderCreatedIfMissing [
	self assert: appClass defaultAppFolder exists
]

{ #category : #running }
PjAppPathTest >> testNilHtmlFolderAndNilJsFolder [
	appClass appHtmlSubFolder: nil.
	appClass appJsSubFolder: nil.
	self assert: appClass appFullHtmlFolderPath equals: appClass appFolder.
	self assert: appClass appFullJsFolderPath equals: appClass appFullHtmlFolderPath.
]

{ #category : #running }
PjAppPathTest >> testNilHtmlFolderFolderButNotNilJsFolder [
	appClass appHtmlSubFolder: nil.
	appClass appJsSubFolder: 'js'.
	self assert: appClass appFullHtmlFolderPath equals: appClass appFolder.
	self assert: appClass appFullJsFolderPath equals: appClass appFullHtmlFolderPath / 'js'.
]

{ #category : #running }
PjAppPathTest >> testNotNilHtmlFolderAndNotNilJsFolder [

	appClass appHtmlSubFolder: 'www'.
	appClass appJsSubFolder: 'js'.
	self
		assert: appClass appFullHtmlFolderPath
		equals: appClass appFolder / 'www'.
	self assert: appClass appFullHtmlFolderPath exists.
	self
		assert: appClass appFullJsFolderPath
		equals: appClass appFullHtmlFolderPath / 'js'.
	self assert: appClass appFullJsFolderPath exists.

]

{ #category : #running }
PjAppPathTest >> testNotNilHtmlFolderButNilJsFolder [
	appClass appHtmlSubFolder: 'www'.
	appClass appJsSubFolder: nil.
	self assert: appClass appFullHtmlFolderPath equals: appClass appFolder/ 'www'.
	self assert: appClass appFullJsFolderPath equals: appClass appFullHtmlFolderPath.
]
