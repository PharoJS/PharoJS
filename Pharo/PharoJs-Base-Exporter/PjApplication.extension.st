Extension { #name : #PjApplication }

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> appFolder [
	<pharoJsSkip>
	
	appFolder ifNil: [ 
		appFolder := [ self defaultAppFolder ]
			             on: Exception
			             do: [ nil ] ].
	self ifInvalidFolder: appFolder do: [ self setUpAppFolder ].
	^ appFolder
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> appFolder: anObject [
	<pharoJsSkip>
	
	appFolder := anObject
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> appFullJsFileName [
	<pharoJsSkip>
	
	^ self appFullJsFolderPath / self appJsFileName
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> appFullJsFolderPath [
	<pharoJsSkip>
	
	self appJsSubFolder ifNotNil: [: subfolder|
		^self appFolder / subfolder 
	].
	^self appFolder
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> appJsFileName [
	<pharoJsSkip>
	
	^ 'index.js'
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> appJsSubFolder [
	<pharoJsSkip>
	"Subclass might return, e.g. 'js' if you want the javascript to be in the js sub-directory. 
	Useful, when you need to access the app/project folder that is different from the JS folder as with PhoneGap."
	
	^ nil
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> defaultAppFolder [
	<pharoJsSkip>
	
	^self defaultAppFolderParent / self defaultAppFolderName
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> defaultAppFolderName [
	<pharoJsSkip>
	
	^ self name
]

{ #category : #'*PharoJs-Base-Exporter' }
PjApplication class >> defaultAppFolderParent [
	<pharoJsSkip>
	
	^ self repositoryPath / self defaultAppFolderParentName / self package name
]

{ #category : #'*PharoJs-Base-Exporter' }
PjApplication class >> defaultAppFolderParentName [
	<pharoJsSkip>
	
	^'HTML'
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> exportApp [
	<pharoJsSkip>
	
	self exporterClass exportApp: self appClass.
	self inform: 'DONE exporting JS code for ', self name
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> exportApp: version [
	<pharoJsSkip>
	
	exportVersion := version.
	self exportApp
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> exportVersion [
	<pharoJsSkip>
	
	self error: 'Override this in your application with the code:
exportVersion
	<jsLiteralGenerator>
	^ exportVersion'
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> exporterClass [
	<pharoJsSkip>
	
	^ PjFileExporter
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> globalsPools [
	<pharoJsSkip>
	
	^ self allSharedPoolsRecursive select: #isJavascriptGlobalsPool
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> ifInvalidFolder: folder do: aBlock [
	<pharoJsSkip>
	
	(folder isNil or: [folder exists not]) ifTrue: aBlock
]

{ #category : #'*PharoJs-Base-Exporter-App' }
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

{ #category : #'*PharoJs-Base-Exporter' }
PjApplication class >> repository [
	<pharoJsSkip>
	
	| packageName |
	packageName := self package name.
	^IceRepository registry  detect: [: repo | repo includesPackageNamed: packageName].
]

{ #category : #'*PharoJs-Base-Exporter' }
PjApplication class >> repositoryPath [
	<pharoJsSkip>
	
	^self repository location
]

{ #category : #'*PharoJs-Base-Exporter' }
PjApplication class >> resetAppFolder [
	self appFolder: nil
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> setUpAppFolder [
	<pharoJsSkip>
	
	| folder |
	folder := UIManager default chooseDirectory: self setUpAppFolderPrompt.
	self ifInvalidFolder: folder do: [  
		^self error: 'PharoJS: Invalid folder for app ', self name].
	self appFolder: folder.
]

{ #category : #'*PharoJs-Base-Exporter-App' }
PjApplication class >> setUpAppFolderPrompt [

	^ 'PharoJS: Folder for app ' , self name , ' please?'
]
