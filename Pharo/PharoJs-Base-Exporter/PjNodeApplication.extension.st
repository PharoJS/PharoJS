Extension { #name : #PjNodeApplication }

{ #category : #'*PharoJs-Base-Exporter' }
PjNodeApplication class >> beforeExportApp [

	<pharoJsSkip>
	super beforeExportApp.
	self ensureRequiredModulesInstalled.

]

{ #category : #'*PharoJs-Base-Exporter' }
PjNodeApplication class >> ensureRequiredModulesInstalled [

	<pharoJsSkip>
	self modulesFolder exists ifTrue: [ ^ self ].
	(self appFolder / 'package-lock.json') exists ifFalse: [ ^ self ].
	self inform: 'Installing NPM modules for ' , self name.
	LibC runCommand: self installNpmModulesCommandLine
]

{ #category : #'*PharoJs-Base-Exporter' }
PjNodeApplication class >> installNpmModulesCommandLine [
	<pharoJsSkip>
	^String streamContents: [ : str |
		str << 
		'cd';
		space ; << self appFolder absolutePath pathString; << $; ;
		<< 'npm install']
]

{ #category : #'*PharoJs-Base-Exporter' }
PjNodeApplication class >> polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet [
	<pharoJsSkip>
	
	^ (super polyfill: aPolyfillClass withTranspiler: aTranspiler unlessIn: aSet) and: [
		aPolyfillClass nodePolyfill: aTranspiler.
		true
	]
]
