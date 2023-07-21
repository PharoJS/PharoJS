"
I am for browsers that have more resources than the CSS and HTML files that need to be loaded.
"
Class {
	#name : #PjFileBasedBrowserBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#traits : 'PjTWebBridgeClient',
	#classTraits : 'PjTWebBridgeClient classTrait',
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #'accessing - defaults' }
PjFileBasedBrowserBridgeClient >> defaultAppClass [

	^ PjMinimalFileBasedWebApp
]

{ #category : #accessing }
PjFileBasedBrowserBridgeClient >> urlString [

	^ self appClass appHtmlUrlString
]
