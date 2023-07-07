Class {
	#name : #PjHelloWorldExpressClientApp,
	#superclass : #PjFileBasedWebApp,
	#category : #'PharoJs-Examples-ExpressJS'
}

{ #category : #accessing }
PjHelloWorldExpressClientApp class >> defaultAppFolderName [
	<pharoJsSkip>

	^ PjHelloWorldApp staticFilesFolderName
]

{ #category : #accessing }
PjHelloWorldExpressClientApp class >> defaultAppFolderParent [
	<pharoJsSkip>

	^ PjHelloWorldApp appFolder
]
