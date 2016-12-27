Class {
	#name : #PjMinimalApp,
	#superclass : #PjFileBasedBrowserApp,
	#category : #'PharoJsTestFramework-Test'
}

{ #category : #'pharojs setup' }
PjMinimalApp class >> setUpAppFolderPrompt [
	^ 'PharoJS: Folder for app ', self name, ' (see GIT repo https://github.com/bouraqadi/PharoJS.git sub-folder PharoJsTestFramework-Test/MinimalApp/) please?'.
]
