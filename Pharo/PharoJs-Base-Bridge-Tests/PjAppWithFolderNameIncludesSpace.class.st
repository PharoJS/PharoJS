Class {
	#name : #PjAppWithFolderNameIncludesSpace,
	#superclass : #PjFileBasedWebApp,
	#category : #'PharoJs-Base-Bridge-Tests-Support'
}

{ #category : #exporting }
PjAppWithFolderNameIncludesSpace class >> defaultAppFolderName [
	<pharoJsSkip>
	^'Folder Name With Space'
]
