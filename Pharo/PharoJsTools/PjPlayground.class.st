"
I am a version of Playground for PharoJS bridges.
"
Class {
	#name : #PjPlayground,
	#superclass : #GTPlayground,
	#instVars : [
		'bridge',
		'bridgeVar',
		'allJavascriptGlobals'
	],
	#category : #'PharoJsTools-Playground'
}

{ #category : #'as yet unclassified' }
PjPlayground class >> openFor: aPjBridge [
	^ self basicNew initializeWithBridge: aPjBridge
]

{ #category : #'world menu' }
PjPlayground class >> pharoJsMenuOn: aBuilder [ 
	<worldMenu>
	(aBuilder item: #PharoJsPlayground)
		label: 'PharoJs Playground';
		target: PjPlayground;
		action: [ self new ];
		withSeparatorAfter; 
		icon: Smalltalk tools workspace taskbarIcon
]

{ #category : #actions }
PjPlayground >> actOnBrowserClosing: ann [
	
	super actOnBrowserClosing: ann.
	bridge ifNotNil: [bridge stop]

]

{ #category : #accessing }
PjPlayground >> addBinding: anAssociation [
	|bindings|
	bindings := self currentBindings copy.
	bindings removeKey: anAssociation key ifAbsent: [ ].
	bindings add: anAssociation.
	self setBindings: bindings.
]

{ #category : #accessing }
PjPlayground >> allJavascriptGlobals [
	^ allJavascriptGlobals ifNil: [
		allJavascriptGlobals := PjProxyGlobal allJavascriptGlobals
	]
]

{ #category : #accessing }
PjPlayground >> bridge [
	^ bridge
]

{ #category : #accessing }
PjPlayground >> bridge: anObject [
	bridge ifNotNil: [ bridge stop ].
	self allJavascriptGlobals do: [ :name |
		self removeBinding: name -> nil ].
	bridge := anObject.
	anObject ifNil: [
		self label: '...disconnected...'.
		^ self].
	self
		label: anObject clientTitle;
		setupProxies
]

{ #category : #accessing }
PjPlayground >> bridgeVar [
	^ bridgeVar
]

{ #category : #building }
PjPlayground >> codePresentationIn: composite [
	^ composite custom: (PjPresentation onPlayground: self) 
]

{ #category : #initialization }
PjPlayground >> initPage: page [
	| bindings |
	self openOn: page.
	bridgeVar := (PjWorkspaceBridgeVariable key: #bridge value: nil)
		playground: self.
	bindings := Dictionary newFrom: {bridgeVar}.
	self setBindings: bindings.
	self label: 'PharoJS Playground'
]

{ #category : #initialization }
PjPlayground >> initialize [
	| page |
	super initialize.
	page := GTPlayPage new saveContent:
		'" cmd-D on the following line will open a bridge and globals will be defined"', String cr
		,'bridge := ' , PjBrowserApplication name, ' bridge start.' , String cr
		,'bridge evalBlock: [ PjLoadForTest fortyTwo ]. " loads the referenced classes and executes the block "', String cr
		,'bridge loadClass: PjLoadForTest. " reloads methods "', String cr
		,'console dir: document.', String cr
		,'document fonts. " inspect this "', String cr
		,'bridge evalBlock: [Math sin: 1]. " inspect or print this "', String cr
		,'document body style backgroundColor: ''#fee''.', String cr
		;
		yourself.
	self initPage: page
]

{ #category : #initialization }
PjPlayground >> initializeWithBridge: aPjBridge [
	| page |
	super initialize.
	page := GTPlayPage new saveContent: aPjBridge playgroundInitialContent;
		yourself.
	self initPage: page.
	bridgeVar value: aPjBridge
]

{ #category : #proxies }
PjPlayground >> makeJsGlobal: jsGlobalName [
	^ (PjWorkspaceGlobalVariable key: jsGlobalName)
		bridge: bridge;
		yourself
]

{ #category : #proxies }
PjPlayground >> setupProxies [
	| dict |
	bridge ifNil: [ ^ self ].
	dict := Dictionary new.
	dict add: bridgeVar.
	bridge client jsGlobalNames
		do: [ :jsGlobalName |
			dict add: (self makeJsGlobal: jsGlobalName)].
	self setBindings: dict.
	bridge setExtraBindings: dict.

]
