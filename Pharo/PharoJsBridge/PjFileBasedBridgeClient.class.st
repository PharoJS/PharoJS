Class {
	#name : #PjFileBasedBridgeClient,
	#superclass : #PjBridgeClient,
	#category : #'PharoJsBridge-Client-Kernel'
}

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
