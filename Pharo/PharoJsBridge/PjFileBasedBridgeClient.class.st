"
I am the super class for bridge clients that need to write out the javascript file.  This includes NodeJS apps and browsers that have more resources than the CSS and HTML files.
"
Class {
	#name : #PjFileBasedBridgeClient,
	#superclass : #PjBridgeClient,
	#category : #'PharoJsBridge-Client-Kernel'
}

{ #category : #files }
PjFileBasedBridgeClient >> appFolder [
	^ self appClass appFolder
]

{ #category : #accessing }
PjFileBasedBridgeClient >> exporterClass [
	^ PjFileExporter
]

{ #category : #files }
PjFileBasedBridgeClient >> fileName [
	^ self appClass appFullJsFileName
]

{ #category : #activity }
PjFileBasedBridgeClient >> start [
	self writeFiles.

]

{ #category : #files }
PjFileBasedBridgeClient >> writeFiles [
	exporter writeJavascriptFileNamed: self fileName.
]
