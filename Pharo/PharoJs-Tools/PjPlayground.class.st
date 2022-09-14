Class {
	#name : #PjPlayground,
	#superclass : #StPlayground,
	#instVars : [
		'bridge'
	],
	#category : #'PharoJs-Tools-Playground'
}

{ #category : #accessing }
PjPlayground class >> defaultTitle [

	^ 'PharoJS Playground'
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
 	self contents: '"Connection established with Javascript"'
]
