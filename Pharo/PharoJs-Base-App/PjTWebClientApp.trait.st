Trait {
	#name : #PjTWebClientApp,
	#category : #'PharoJs-Base-App'
}

{ #category : #exporting }
PjTWebClientApp classSide >> defaultAppFolderName [

	<pharoJsSkip>
	^ self serverAppClass staticFilesFolderName
]

{ #category : #exporting }
PjTWebClientApp classSide >> defaultAppFolderParent [

	<pharoJsSkip>
	^ self serverAppClass appFolder
]

{ #category : #exporting }
PjTWebClientApp classSide >> serverAppClass [

	<pharoJsSkip>
	^ self explicitRequirement 
]
