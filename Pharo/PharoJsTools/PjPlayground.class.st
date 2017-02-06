"
I am a version of Playground for PharoJS bridges.
"
Class {
	#name : #PjPlayground,
	#superclass : #GTPlayground,
	#instVars : [
		'bridge',
		'bridgeVar',
		'allJavascriptGlobals',
		'page',
		'pageTitle'
	],
	#category : #'PharoJsTools-Playground'
}

{ #category : #opening }
PjPlayground class >> open [
	"self open"
	^self new openPage
]

{ #category : #opening }
PjPlayground class >> openFor: aPjBridge [
	^ self basicNew initializeWithBridge: aPjBridge
]

{ #category : #'world menu' }
PjPlayground class >> pharoJsMenuOn: aBuilder [ 
	<worldMenu>
	(aBuilder item: #PharoJsPlayground)
		label: 'PharoJs Playground';
		target: PjPlayground;
		action: [ self open];
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
		allJavascriptGlobals := PjProxyForGlobal allJavascriptGlobals
	]
]

{ #category : #accessing }
PjPlayground >> bridge [
	^ bridge
]

{ #category : #accessing }
PjPlayground >> bridge: aBridge [
	bridge ifNotNil: [
		bridge stop .
		self allJavascriptGlobals do: [ :name |
			self removeBinding: name -> nil ]].
	bridge := aBridge.
	aBridge ifNil: [
		self label: '...disconnected...'.
		^ self].
	self page saveContent: self page content, bridge playgroundInitialContent.
	self
		label: 'PharoJS Playground: ', aBridge clientTitle;
		setupProxies
]

{ #category : #accessing }
PjPlayground >> bridgeVar [
	^ bridgeVar
]

{ #category : #accessing }
PjPlayground >> bridgeVarValue: aBridge [
	self bridgeVar value: aBridge
]

{ #category : #building }
PjPlayground >> codeIn: a [
	^ (super codeIn: a)
		title: [ :aPage | 
			GLMLiveLabelBrick new
				textLogic: [pageTitle];
				yourself ];
		yourself
]

{ #category : #building }
PjPlayground >> codePresentationIn: composite [
	^ composite custom: (PjPresentation onPlayground: self) 
]

{ #category : #initialization }
PjPlayground >> initialize [
	super initialize.
	bridgeVar := (PjWorkspaceBridgeVariable key: #bridge value: nil)
		playground: self;
		yourself.
	self page: (GTPlayPage new saveContent:
		'" cmd-D on the following line will open a bridge and globals will be defined"', String cr
		,'bridge := ' , PjBrowserApplication name, ' bridge start.' , String cr;
		yourself).
	pageTitle := ''.
	self label: 'PharoJS Playground'.


]

{ #category : #initialization }
PjPlayground >> initializeWithBridge: aPjBridge [
	| waitTime endTime |
	super initialize.
	aPjBridge startWithoutWaitingForClient.
	bridge := aPjBridge.
	waitTime := 60 seconds.
	pageTitle := 'waiting for connection'.
	self page: (GTPlayPage new
		title: pageTitle;
		saveContent: '"  listening on:', String cr, String cr,
			'     ',aPjBridge serverUrl asString, String cr, String cr,'"';
		yourself).
	self openPage.
	self label: 'PharoJS Playground: ',aPjBridge clientTitle.
	endTime := DateAndTime now + waitTime.
	aPjBridge waitForClientToStartFor: waitTime doing: [
		pageTitle := 'waiting for connection for ',(endTime-DateAndTime now) seconds asString,' more seconds'.
		World doOneCycle
	].
	pageTitle := 'bridge connected on port ',aPjBridge port asString.
	self page
		saveContent: '" a bridge is now open and globals are defined"', String cr.
	self startOn: self page.
	bridge := nil.
	self bridgeVarValue: aPjBridge
]

{ #category : #proxies }
PjPlayground >> makeJsGlobal: jsGlobalName [
	^ (PjWorkspaceGlobalVariable key: jsGlobalName)
		bridge: bridge;
		yourself
]

{ #category : #initialization }
PjPlayground >> openPage [
	| window bindings |
	window := self openOn: self page.
	bindings := Dictionary newFrom: {self bridgeVar}.
	self setBindings: bindings.
	^window
]

{ #category : #accessing }
PjPlayground >> page [
	^ page
]

{ #category : #accessing }
PjPlayground >> page: anObject [
	page := anObject
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
