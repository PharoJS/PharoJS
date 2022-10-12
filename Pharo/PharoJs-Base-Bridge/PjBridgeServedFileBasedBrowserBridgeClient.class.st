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

	server delegate map: #web to: (ZnStaticFileServerDelegate new
			 prefixFromString: 'web';
			 directory: aString asFileReference;
			 yourself)
]

{ #category : #accessing }
PjBridgeServedFileBasedBrowserBridgeClient >> initializeWithBridge: aBridge [

	super initializeWithBridge: aBridge.
	self initMappingOn: self server andFolder: self folderName fullName.

]

{ #category : #actions }
PjBridgeServedFileBasedBrowserBridgeClient >> urlString [

	^ self server url / 'web' / 'index.html'
]
