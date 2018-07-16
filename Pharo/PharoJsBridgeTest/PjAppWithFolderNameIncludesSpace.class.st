Class {
	#name : #PjAppWithFolderNameIncludesSpace,
	#superclass : #PjFileBasedBrowserApp,
	#category : #'PharoJsBridgeTest-Support'
}

{ #category : #exporting }
PjAppWithFolderNameIncludesSpace class >> defaultAppFolderName [
	<pharoJsSkip>
	^'Folder Name With Space'
]
