Class {
	#name : #PjBridgeServedFileBasedBrowserBridgeClient,
	#superclass : #PjFileBasedBrowserBridgeClient,
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #'accessing - files' }
PjBridgeServedFileBasedBrowserBridgeClient >> folderName [

	^ self appClass appFullHtmlFolderPath 
]

{ #category : #'as yet unclassified' }
PjBridgeServedFileBasedBrowserBridgeClient >> initMappingOn: server andFolder: aString [

	server delegate 
		map:#'index.html' to: [ :request | 
			ZnResponse ok:
					(ZnEntity html: (aString asFileReference / 'index.html') contents) ];
		map: #'index.js' to: [ :request | 
			ZnResponse ok:
					(ZnEntity javascript: (aString asFileReference / 'index.js') contents) ].
]

{ #category : #actions }
PjBridgeServedFileBasedBrowserBridgeClient >> startJsInterpreter [

	"start javascript interpreter"

	self initMappingOn: self server andFolder: self folderName fullName.
	super startJsInterpreter
]

{ #category : #actions }
PjBridgeServedFileBasedBrowserBridgeClient >> urlString [

	^ self server url / 'index.html'
]
