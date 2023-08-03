"
I am the class that all PharoJS applications should extend.

I contain methods that DOM (Browser and PhoneGap) and NodeJS applications have in common.
"
Class {
	#name : #PjApplication,
	#superclass : #Object,
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
	#category : #'PharoJs-Base-App'
}

{ #category : #'accessing - description' }
PjApplication class >> appClass [
	<pharoJsSkip>
	
	^ self
]

{ #category : #'accessing - description' }
PjApplication class >> appClasses [
	<pharoJsSkip>

	^ self appClass withAllSuperclasses
]

{ #category : #'accessing - description' }
PjApplication class >> appLaunchBlock [
	<pharoJsSkip>

	| appClass |
	appClass := self.
	^[ appClass start ] asClosedBlock
]

{ #category : #'accessing - description' }
PjApplication class >> appPackages [
	<pharoJsSkip>
	
	^ Set new
]

{ #category : #'instance creation' }
PjApplication class >> currentInstance [

	^ currentInstance
]

{ #category : #'node package management' }
PjApplication class >> ensureRequiredPackagesInstalled [

	<pharoJsSkip>
	self npmPackageNames ifEmpty: [
		^ self inform: 'No NPM package required' ].
	self inform:
		'Ensure required NPM pacakges installed for ' , self name.
	self inAppFolderRunCommandLine: [ :str |
		str << 'npm init -y;'.
		self npmPackageNames do: [ :packageName |
			str
				<< 'npm install ';
				<< packageName;
				<< $; ] ]
]

{ #category : #accessing }
PjApplication class >> headerLine [
	<pharoJsSkip>
	
	^ nil
]

{ #category : #'node package management' }
PjApplication class >> inAppFolderRunCommandLine: aBlock [

	<pharoJsSkip>
	| commandLine |
	commandLine := String streamContents: [ :str |
		               str
			               << 'cd ';
			               << self appFullJsFolderPath pathString;
			               << $;.
		               aBlock value: str ].
	LibC system: commandLine
]

{ #category : #'node package management' }
PjApplication class >> modulesFolder [

	<pharoJsSkip>
	^ self appFullJsFolderPath / self modulesFolderName
]

{ #category : #'node package management' }
PjApplication class >> modulesFolderName [
	^'node_modules'
]

{ #category : #'node package management' }
PjApplication class >> npmPackageNames [

	<pharoJsSkip>
	^#()
]

{ #category : #accessing }
PjApplication class >> pharoJsSelectorPrefix [
	<pharoJsSkip>
	
	^ 'pj_'
]

{ #category : #'instance creation' }
PjApplication class >> resetCurrentInstance [
	<script>
	
	currentInstance := nil
]

{ #category : #'accessing - description' }
PjApplication class >> setupCode [
	<pharoJsSkip>
	
	^ ''
]

{ #category : #'start-stop application' }
PjApplication class >> start [
	<script>
	
	self whenJsReady: [ self startInstance ]
]

{ #category : #private }
PjApplication class >> startInstance [
	
	self currentInstance ifNil: [ currentInstance := self new ].
	self currentInstance start
]

{ #category : #'start-stop application' }
PjApplication class >> stop [
	<script>
	
	self currentInstance ifNil: [ ^ self ].
	self currentInstance stop
]

{ #category : #private }
PjApplication class >> whenJsReady: aBlock [

	self subclassResponsibility
]

{ #category : #modules }
PjApplication >> modulesManager [
	^PjNodeModulesManager default
]

{ #category : #modules }
PjApplication >> require: aString [

	^ self modulesManager require: aString
]

{ #category : #'start-stop' }
PjApplication >> start [
]

{ #category : #'start-stop' }
PjApplication >> stop [
]
