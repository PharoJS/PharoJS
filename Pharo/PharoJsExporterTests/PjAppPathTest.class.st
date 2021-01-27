Class {
	#name : #PjAppPathTest,
	#superclass : #TestCase,
	#instVars : [
		'appClass'
	],
	#category : #'PharoJsExporterTests-Tests'
}

{ #category : #running }
PjAppPathTest >> resetAppClass [
	appClass appHtmlSubFolder: nil.
	appClass appJsSubFolder: nil
]

{ #category : #running }
PjAppPathTest >> setUp [
	super setUp.
	appClass := PjAppForPathTest.
	appClass appFolder: '/some/folder' asFileReference. 
	self resetAppClass
]

{ #category : #running }
PjAppPathTest >> tearDown [
	super tearDown.
	self resetAppClass
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
	self assert: appClass appFullHtmlFolderPath equals: appClass appFolder/'www'.
	self assert: appClass appFullJsFolderPath equals: appClass appFullHtmlFolderPath / 'js'.
	
]

{ #category : #running }
PjAppPathTest >> testNotNilHtmlFolderButNilJsFolder [
	appClass appHtmlSubFolder: 'www'.
	appClass appJsSubFolder: nil.
	self assert: appClass appFullHtmlFolderPath equals: appClass appFolder/ 'www'.
	self assert: appClass appFullJsFolderPath equals: appClass appFullHtmlFolderPath.
	
]
