Class {
	#name : #PjBridgeServedFileBasedBrowserBridgeClient,
	#superclass : #PjFileBasedBrowserBridgeClient,
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #actions }
PjBridgeServedFileBasedBrowserBridgeClient >> appUrlPrefixString [
	^self appClass name
]

{ #category : #accessing }
PjBridgeServedFileBasedBrowserBridgeClient >> initializeWithBridge: aBridge [

	| staticFileDelegate |
	super initializeWithBridge: aBridge.
	staticFileDelegate := ZnStaticFileServerDelegate new.
	staticFileDelegate
		prefixFromString: self appUrlPrefixString;
		directory: self appClass appFullHtmlFolderPath asFileReference.
	self server delegate map: self appUrlPrefixString to: staticFileDelegate
]

{ #category : #actions }
PjBridgeServedFileBasedBrowserBridgeClient >> url [

	^ self server url / self appUrlPrefixString 
]

{ #category : #actions }
PjBridgeServedFileBasedBrowserBridgeClient >> urlString [

	^ self server url / 'web' / 'index.html'
]
