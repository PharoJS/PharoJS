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

{ #category : #actions }
PjBridgeServedFileBasedBrowserBridgeClient >> urlString [

	^ self server url / 'web' / 'index.html'
]
