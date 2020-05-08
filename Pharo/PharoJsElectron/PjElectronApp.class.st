"
A PjApplication for desktop applications using the popular framework electron.js (https://www.electronjs.org/)

Uses the class PjElectronPolyfill to create a desktop application.

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
	#category : #PharoJsElectron
}

{ #category : #'start-stop' }
PjElectronApp >> start [
   electron := ElectronApp new.
]
