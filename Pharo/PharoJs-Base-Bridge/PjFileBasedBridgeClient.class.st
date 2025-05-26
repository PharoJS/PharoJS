"
I am the super class for bridge clients that need to write out the javascript file.  This includes NodeJS apps and browsers that have more resources than the CSS and HTML files.
"
Class {
	#name : 'PjFileBasedBridgeClient',
	#superclass : 'PjBridgeClient',
	#category : 'PharoJs-Base-Bridge-Client-Kernel',
	#package : 'PharoJs-Base-Bridge',
	#tag : 'Client-Kernel'
}

{ #category : 'exporting' }
PjFileBasedBridgeClient >> appFolder [

	^ self appClass appFolder
]

{ #category : 'exporting' }
PjFileBasedBridgeClient >> fileName [

	^ self appClass appFullJsFileName
]

{ #category : 'actions' }
PjFileBasedBridgeClient >> start [
	self writeFiles.
	super start
]

{ #category : 'exporting' }
PjFileBasedBridgeClient >> writeFiles [

	exporter writeFiles
]
