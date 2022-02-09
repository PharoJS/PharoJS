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
		'pageTitle',
		'demo'
	],
	#category : #'PharoJs-Tools-Playground'
}

{ #category : #'world menu' }
PjPlayground class >> applicationList [
	^ (PjApplication allSubclasses select: [ :class |
				class isAbstract not and: [ (class hasClassMethod: #playgroundDoNotList) not ]
		]) sort: [ : l : r | l name <= r name ]
]

{ #category : #opening }
PjPlayground class >> open [
	"self open"
	^self new openPage
]

{ #category : #opening }
PjPlayground class >> openDemo [
	"self openDemo"
	^self new openDemoPage
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
		icon: (self iconNamed: #smallWindowIcon);
		with: [
			(aBuilder item: #simple)
				action: [ self open ].
			self applicationList do: [ :class |
				| n |
				n := class name.
				(aBuilder item: n asSymbol)
					label: n;
					with: [
						(aBuilder item: (n,':pharo') asSymbol)
							label: 'launch on Pharo';
							action: [ class pharoPlayground ].
						(aBuilder item: (n,':js') asSymbol)
							label: 'launch on remote';
							action: [ class playground ].
						(aBuilder item: (n,':browse') asSymbol)
							label: 'export app';
							action: [ class exportApp ].
						(aBuilder item: (n,':browse') asSymbol)
							label: 'browse';
							action: [ class browse ].
			]].
			(aBuilder item: #HelpPharoJs)
				label: 'PharoJs Help';
				icon: (self iconNamed: #smallHelp);
				action: [ HelpBrowser openOn: PharoJsHelp ].
		]
]

{ #category : #'world menu' }
PjPlayground class >> popUpMenu [
	" self popUpMenu "
	| builder |
	builder := PragmaMenuBuilder new pragmaKeyword: #worldMenu.
	builder pragmaCollector filter: [ : prg | prg selector = #pharoJsMenuOn:];reset.
	self pharoJsMenuOn: builder.
	builder menu popUpInWorld.
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
PjPlayground >> demo [
	^ true==demo
]

{ #category : #initialization }
PjPlayground >> demo: aBoolean [
	demo := aBoolean
]

{ #category : #initialization }
PjPlayground >> initialize [
	self initializeCommonBridge: nil.
	self page:
		(GTPlayPage new
			saveContent:
				'" cmd-D on the following line will open a bridge and globals will be defined"'
				, String cr , 'bridge := ' , PjWebApplication name
				, ' bridge start.' , String cr;
			yourself).
	pageTitle := ''.
	self label: 'PharoJS Playground'
]

{ #category : #initialization }
PjPlayground >> initializeCommonBridge: aPjBridgeOrNil [
	super initialize.
	bridge := aPjBridgeOrNil.
	bridgeVar := (PjWorkspaceBridgeVariable key: #bridge value: bridge)
		playground: self;
		yourself
]

{ #category : #initialization }
PjPlayground >> initializeWithBridge: aPjBridge [
	| waitTime endTime |
	self initializeCommonBridge: aPjBridge startWithoutWaitingForClient.
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
PjPlayground >> openDemoPage [
	demo := true.
	^ self openPage
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
