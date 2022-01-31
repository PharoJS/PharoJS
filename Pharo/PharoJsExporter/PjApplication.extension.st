Extension { #name : #PjApplication }

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> appFolder [
	<pharoJsSkip>
	appFolder ifNil: [ appFolder := [self defaultAppFolder] on: Exception do: [ nil ] ].
	self ifInvalidFolder: appFolder do:[self setUpAppFolder].
	^appFolder
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> appFolder: anObject [
	<pharoJsSkip>
	appFolder := anObject
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> appFullJsFileName [
	<pharoJsSkip>
	^self appFullJsFolderPath / self appJsFileName
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> appFullJsFolderPath [
	<pharoJsSkip>
	self appJsSubFolder ifNotNil: [: subfolder|
		^self appFolder / subfolder 
	].
	^self appFolder
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> appJsFileName [
	<pharoJsSkip>
	^ 'index.js'
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> appJsSubFolder [
	<pharoJsSkip>
	"Subclass might return, e.g. 'js' if you want the javascript to be in the js sub-directory. 
	Useful, when you need to access the app/project folder that is different from the JS folder as with PhoneGap."
	^ nil
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> defaultAppFolder [
	<pharoJsSkip>
	^self defaultAppFolderParent / self defaultAppFolderName
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> defaultAppFolderName [
	<pharoJsSkip>
	^self name
]

{ #category : #'*PharoJsExporter' }
PjApplication class >> defaultAppFolderParent [
	<pharoJsSkip>
	^self repositoryPath / self defaultAppFolderParentName / self package name
]

{ #category : #'*PharoJsExporter' }
PjApplication class >> defaultAppFolderParentName [
	<pharoJsSkip>
	^'HTML'
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> exportApp [
	<pharoJsSkip>
	self exporterClass exportApp: self appClass.
	self inform: 'DONE exporting JS code for ', self name
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> exportApp: version [
	<pharoJsSkip>
	exportVersion := version.
	self exportApp.
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> exportVersion [
	<pharoJsSkip>
	self error: 'Override this in your application with the code:
exportVersion
	<jsLiteralGenerator>
	^ exportVersion'
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> exporterClass [
	<pharoJsSkip>
	^ PjFileExporter
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> globalsPools [
	<pharoJsSkip>
	^ self allSharedPoolsRecursive select: #isJavascriptGlobalsPool
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> ifInvalidFolder: folder do: aBlock [
	<pharoJsSkip>
	(folder isNil or: [folder exists not]) ifTrue: aBlock
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet [
	<pharoJsSkip>
	(aSet includes: aPolyfillClass) ifFalse: [
		aSet add: aPolyfillClass.
		aPolyfillClass requiredPolyfills do: [ : pool |
			self polyfill: pool withTranspiler: aTranspiler unlessIn: aSet
		].
		^ true
	].
	^ false
]

{ #category : #'*PharoJsExporter' }
PjApplication class >> repository [
	<pharoJsSkip>
	| packageName |
	packageName := self package name.
	^IceRepository registry  detect: [: repo | repo includesPackageNamed: packageName].
]

{ #category : #'*PharoJsExporter' }
PjApplication class >> repositoryPath [
	<pharoJsSkip>
	^self repository location
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> setUpAppFolder [
	<pharoJsSkip>
	| folder |
	folder := UIManager default chooseDirectory: self setUpAppFolderPrompt.
	self ifInvalidFolder: folder do: [  
		^self error: 'PharoJS: Invalid folder for app ', self name].
	self appFolder: folder.
]

{ #category : #'*PharoJsExporter-App' }
PjApplication class >> setUpAppFolderPrompt [
	^ 'PharoJS: Folder for app ', self name, ' please?'.
]
