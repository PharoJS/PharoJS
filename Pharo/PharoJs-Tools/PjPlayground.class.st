Class {
	#name : #PjPlayground,
	#superclass : #StPlayground,
	#instVars : [
		'bridge'
	],
	#category : #'PharoJs-Tools-Playground'
}

{ #category : #'world menu' }
PjPlayground class >> applicationList [
	^ (PjApplication allSubclasses select: [ :class |
				class isAbstract not and: [ (class hasClassMethod: #playgroundDoNotList) not ]
		]) sort: [ : l : r | l name <= r name ]
]

{ #category : #accessing }
PjPlayground class >> defaultTitle [

	^ 'PharoJS Playground'
]

{ #category : #initialization }
PjPlayground class >> initialize [

	SystemAnnouncer uniqueInstance
		unsubscribe: self;
		when: ClassAnnouncement do: [ 
			self resetMenuBar ]
]

{ #category : #opening }
PjPlayground class >> open [

	| playground |
	playground := self new.
	playground open.
	^ playground
]

{ #category : #opening }
PjPlayground class >> openFor: aPjBridge [

	| playground |
	playground := self open.
	playground initializeWithBridge: aPjBridge.
	^ playground
]

{ #category : #'world menu' }
PjPlayground class >> pharoJsMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #PharoJsPlayground)
		order: 40;
		label: 'PharoJs Playground';
		icon: (self iconNamed: #smallWindowIcon);
		with: [ 
			self applicationList do: [ :class | 
					| n |
					n := class name.
					(aBuilder item: n asSymbol)
						label: n;
						with: [ 
							(aBuilder item: (n , ':pharo') asSymbol)
								label: 'launch on Pharo';
								action: [ class pharoPlayground ].
							(aBuilder item: (n , ':js') asSymbol)
								label: 'launch on remote';
								action: [ class playground ].
							(aBuilder item: (n , ':browse') asSymbol)
								label: 'export app';
								action: [ class exportApp ].
							(aBuilder item: (n , ':browse') asSymbol)
								label: 'browse';
								action: [ class browse ] ] ].
			(aBuilder item: #HelpPharoJs)
				label: 'PharoJs Help';
				icon: (self iconNamed: #smallHelp);
				action: [ HelpBrowser openOn: PharoJsHelp ] ]
]

{ #category : #'world menu' }
PjPlayground class >> resetMenuBar [

	<script>
	MenubarMorph reset
]

{ #category : #accessing }
PjPlayground >> addBinding: anAssociation [

	self firstPage addBinding: anAssociation
]

{ #category : #initialization }
PjPlayground >> addWorkspaceVariableNamed: jsGlobalName value: jsGlobal [

	^ self addBinding:
		  (WorkspaceVariable key: jsGlobalName value: jsGlobal)
]

{ #category : #accessing }
PjPlayground >> bridge [
	^bridge
]

{ #category : #accessing }
PjPlayground >> bridge: aBridge [
	bridge := aBridge 
	
]

{ #category : #initialization }
PjPlayground >> displayWaitingForConnectionMessageForDuration: aDuration [

	| waitDescription |
	waitDescription := String streamContents: [ :str | 
		                   str
			                   << $";
			                   cr;
			                   << 'PharoJS bridge server listening on: ';
			                   print: bridge serverUrl;
			                   cr;
			                   << 'Waiting for client connection for ';
			                   print: aDuration seconds;
			<< ' seconds';
			                   cr;
			                   << $" ].
	self contents: waitDescription
]

{ #category : #initialization }
PjPlayground >> initBindings [

	| jsGlobal |
	self addWorkspaceVariableNamed: #bridge value: bridge.
	bridge client jsGlobalNames do: [ :jsGlobalName | 
		jsGlobal := PjProxy proxyNamed: jsGlobalName onBridge: bridge.
		self addWorkspaceVariableNamed: jsGlobalName value: jsGlobal ]
]

{ #category : #initialization }
PjPlayground >> initTitleWithBridge [

	| newTitle |
	newTitle := String streamContents: [ : ws |
		ws << self class defaultTitle;
		<< ' - ';
		<< bridge clientTitle
	].
	self title: newTitle
]

{ #category : #initialization }
PjPlayground >> initialContents [

	^ String streamContents: [ :str | 
		  self writePlaygroundContentsOn: str ]
]

{ #category : #initialization }
PjPlayground >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenClosedDo: [ bridge stop ]
]

{ #category : #initialization }
PjPlayground >> initializeWithBridge: aPjBridge [

	bridge := aPjBridge.
	bridge startWithoutWaitingForClient.
	self initTitleWithBridge.
	self waitForClientToStart.
	self initBindings.
	self contents: self initialContents
]

{ #category : #accessing }
PjPlayground >> title [
	
	self hasWindow ifFalse: [ ^nil ].
	^ self window title
]

{ #category : #accessing }
PjPlayground >> title: aString [

	self window title: aString
]

{ #category : #initialization }
PjPlayground >> waitForClientToStart [

	| waitTime endTime |
	waitTime := 60 seconds.
	endTime := DateAndTime now + waitTime.
	bridge waitForClientToStartFor: waitTime doing: [ 
		self displayWaitingForConnectionMessageForDuration:
			endTime - DateAndTime now.
		World doOneCycle ].
]

{ #category : #writing }
PjPlayground >> writePlaygroundContentsOn: aWriteStream [ 
	self bridge writePlaygroundContentsOn: aWriteStream 
]
