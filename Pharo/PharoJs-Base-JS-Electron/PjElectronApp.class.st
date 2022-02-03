"
A PjApplication for desktop applications using the popular framework electron.js (https://www.electronjs.org/)

Uses the class PjElectronPolyfill to create a desktop application.

After you generate the main.js file, you must also add an index.html file to be used as a template.

Run the app by navigating to the directory and then use the commands:
$ npm install electron
$ electron.
"
Class {
	#name : #PjElectronApp,
	#superclass : #PjNodeApplication,
	#instVars : [
		'electron'
	],
	#pools : [
		'PjElectronPolyfill'
	],
	#category : #'PharoJs-Base-JS-Electron'
}

{ #category : #exporting }
PjElectronApp class >> appJsFileName [
	<pharoJsSkip>
	^ 'main.js'
]

{ #category : #'interface building' }
PjElectronApp class >> createWindow [
	| myWindow |
	myWindow := ElectronApp BrowserWindow new.
	myWindow loadFile: 'index.html'.
]

{ #category : #'class initialization' }
PjElectronApp class >> initialize [ 
	<javascript: 'ElectronApp.app.whenReady().then(() => PjElectronApp.pj_createWindow())'>
]
