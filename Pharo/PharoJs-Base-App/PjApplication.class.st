"
I am the class that all PharoJS applications should extend.

I contain methods that DOM (Browser and PhoneGap) and NodeJS applications have in common.
"
Class {
	#name : 'PjApplication',
	#superclass : 'Object',
	#pools : [
		'PjUniversalGlobals'
	],
	#classInstVars : [
		'appFolder',
		'currentInstance',
		'port',
		'status',
		'exportVersion'
	],
	#category : 'PharoJs-Base-App',
	#package : 'PharoJs-Base-App'
}

{ #category : 'accessing - description' }
PjApplication class >> appClass [
	<pharoJsSkip>
	
	^ self
]

{ #category : 'accessing - description' }
PjApplication class >> appClasses [
	<pharoJsSkip>

	^ self appClass withAllSuperclasses
]

{ #category : 'accessing - description' }
PjApplication class >> appLaunchBlock [
	<pharoJsSkip>

	| appClass |
	appClass := self.
	^[ appClass start ] asClosedBlock
]

{ #category : 'accessing - description' }
PjApplication class >> appPackages [
	<pharoJsSkip>
	
	^ Set new
]

{ #category : 'instance creation' }
PjApplication class >> currentInstance [

	^ currentInstance
]

{ #category : 'node package management' }
PjApplication class >> ensureRequiredPackagesInstalled [

	<pharoJsSkip>
	self npmPackageNames ifEmpty: [ ^ InformativeNotification signal: 'No NPM package required' ].
	self inform: 'Ensure required NPM packages installed for ' , self name.
	self inAppFolderRunCommandLine: [ :str |
			str << 'npm init -y'.
			self writeCommandDelimiterOn: str.
			self npmPackageNames
				do: [ :packageName | self writeEnsureNpmPackage: packageName on: str ]
				separatedBy: [ self writeCommandDelimiterOn: str ] ]
]

{ #category : 'accessing' }
PjApplication class >> headerLine [
	<pharoJsSkip>
	
	^ nil
]

{ #category : 'node package management' }
PjApplication class >> inAppFolderRunCommandLine: aBlock [

	<pharoJsSkip>
	| commandLine |
	commandLine := String streamContents: [ :str |
		               str << 'cd "' << self appFullJsFolderPath pathString
		               << '"'.
		               self writeCommandDelimiterOn: str.
		               aBlock value: str ].
	OSPlatform current isWindows ifTrue: [
		self
			shellExecute: 'open'
			file: 'C:\Windows\System32\cmd.exe'
			parameters: '/C ' , commandLine
			directory: ''
			show: 5. "SW_SHOW"
		^ self ].
	LibC resultOfCommand: commandLine
]

{ #category : 'node package management' }
PjApplication class >> isPackageInitialized [

	^ (self packageJsonFile ) exists

]

{ #category : 'node package management' }
PjApplication class >> modulesFolder [

	<pharoJsSkip>
	^ self appFullJsFolderPath / self modulesFolderName
]

{ #category : 'node package management' }
PjApplication class >> modulesFolderName [
	^'node_modules'
]

{ #category : 'node package management' }
PjApplication class >> npmPackageNames [

	<pharoJsSkip>
	^#()
]

{ #category : 'node package management' }
PjApplication class >> packageJsonFile [

	^ (self appFullJsFolderPath / 'package.json')
]

{ #category : 'accessing' }
PjApplication class >> pharoJsSelectorPrefix [
	<pharoJsSkip>
	
	^ 'pj_'
]

{ #category : 'instance creation' }
PjApplication class >> resetCurrentInstance [
	<script>
	
	self stop.
	currentInstance := nil
]

{ #category : 'accessing - description' }
PjApplication class >> setupCode [
	<pharoJsSkip>
	
	^ ''
]

{ #category : 'node package management' }
PjApplication class >> shellExecute: lpOperation file: lpFile parameters: lpParameters directory: lpDirectory show: nShowCmd [
	<pharoJsSkip>
	^ self ffiCall: #(
			FFIConstantHandle ShellExecuteA(
     				int 0, "Operation is not associated with a window"
     				String lpOperation,
         			String lpFile,
     				String lpParameters,
     				String lpDirectory,
        			int nShowCmd)) module: #shell32
]

{ #category : 'start-stop application' }
PjApplication class >> start [
	<script>
	
	self whenJsReady: [ self startInstance ]
]

{ #category : 'private' }
PjApplication class >> startInstance [
	
	self currentInstance ifNil: [ currentInstance := self new ].
	self currentInstance start
]

{ #category : 'start-stop application' }
PjApplication class >> stop [
	<script>
	
	self currentInstance ifNil: [ ^ self ].
	self currentInstance stop
]

{ #category : 'private' }
PjApplication class >> whenJsReady: aBlock [

	self subclassResponsibility
]

{ #category : 'node package management' }
PjApplication class >> writeCommandDelimiterOn: str [

	<pharoJsSkip>
	OSPlatform current isWindows ifTrue: [
		str << '&&'.
		^ self ].
	str << ';'
]

{ #category : 'node package management' }
PjApplication class >> writeEnsureNpmPackage: packageName on: str [

	<pharoJsSkip>
	OSPlatform current isWindows ifTrue: [
		str << 'npm list ' << packageName
		<< ' >nul 2>&1 || npm install ' << packageName.
		^ self ].
	str << 'npm list ' << packageName.
	str << '||'.
	str << 'npm install ' << packageName
]

{ #category : 'modules' }
PjApplication >> require: jsModuleName [
	"Loads the JS module if not in cache see https://iifx.dev/en/articles/43105256 "
	"Note: Smalltalk global is transpiled to globalThis."

	^ Smalltalk require: jsModuleName
]

{ #category : 'start-stop' }
PjApplication >> start [
]

{ #category : 'start-stop' }
PjApplication >> stop [
]
