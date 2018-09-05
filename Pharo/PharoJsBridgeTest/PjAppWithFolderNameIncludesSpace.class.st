Class {
	#name : #PjAppWithFolderNameIncludesSpace,
	#superclass : #PjFileBasedWebApp,
	#category : #'PharoJsBridgeTest-Support'
}

{ #category : #exporting }
PjAppWithFolderNameIncludesSpace class >> defaultAppFolderName [
	<pharoJsSkip>
	^'Folder Name With Space'
]
