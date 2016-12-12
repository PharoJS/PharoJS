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

{ #category : #accessing }
PjFileBasedBridgeClient >> title [
	^ appClass title
]

{ #category : #files }
PjFileBasedBridgeClient >> writeFiles [
	exporter writeJavascriptFileNamed: self fileName.
]
