"
A PjBridge is the facade that allows interacting (i.e. evaluting code) with a javascript interpreter. 

Example: 
""1) Start a bridge in a workspace""
bridge := PjBridge startOn: 12345 title: 'Example'.

""2) Open a web browser on http://localhost:12345""

""3) Perform in the workspace the following expressions one at a time. Use 'printIt' to display results. Watch the log on the web browser to see the  javascript code actually peformed.""
bridge eval: '1+2'.
bridge eval: 'x := 6 * 7'.
bridge eval: 'x - 5'.
bridge loadClass: PjCounter.
bridge eval: 'counter := PjCounter new.
counter increment.
counter increment.
counter increment.
counter count.'. 

""4) Once done, don't forget to stop the bridge""
bridge stop.

Instance Variables
	clientClassName:		<String>
	communicationTrialsCount:		<Integer>
	converter:		<PjSmalltalkToJavaScriptConverer>
	server:		<PjServer>

clientClassName
	- Name of the class of the socket wrapper running on the JavaScript client (e.g. PjEvaluatorWebSocketDelegate)

communicationTrialsCount
	- Number of attempts to send/receive data through the webSocket

converter
	- Smalltalk to JavaScript converter. Used to translate Smalltalk code to JavaScript before evaluating it on the client (see #eval: and #loadClass:)

server
	- Manages client connections including the websocket

"
Class {
	#name : #PjBridge,
	#superclass : #Object,
	#instVars : [
		'server',
		'communicationTrialsCount',
		'timeout',
		'proxies',
		'blockClosures',
		'client',
		'runOnPharo',
		'shouldStartJsInterpreter',
		'transpiler',
		'frames',
		'monitor'
	],
	#category : #'PharoJsBridge-Kernel'
}

{ #category : #'instance creation' }
PjBridge class >> bridgeForAppClass: appClass [
	^ self bridgeForAppClass: appClass client: appClass newBridgeClient
]

{ #category : #'instance creation' }
PjBridge class >> bridgeForAppClass: appClass client: bridgeClient [
	^ self new
			client: bridgeClient;
			initializeWithAppClass: appClass;
			yourself
]

{ #category : #accessing }
PjBridge class >> debugClass [
	^ self
]

{ #category : #accessing }
PjBridge class >> defaultApp [
	^PjWebApplication
]

{ #category : #accessing }
PjBridge class >> defaultClientClass [
	^self defaultApp bridgeClientClass
]

{ #category : #'instance creation' }
PjBridge class >> openOn: portNumber title: title [
	^ self new
		openOn: portNumber title: title;
		yourself
]

{ #category : #'bridge handling' }
PjBridge class >> soleBridge [
	^ PjProxyLocalBridge value
	" the following is a hack to make debugging workable if there is only 1 bridge in existence "
		ifNil: [ | instances |
			instances := self allInstances select: #isServerStarted.
			instances size = 1 ifTrue: [ instances first ] ifFalse: [ nil ]
		]
]

{ #category : #'bridge handling' }
PjBridge class >> soleBridge: aBridge [
	PjProxyLocalBridge value: aBridge
]

{ #category : #'instance creation' }
PjBridge class >> startOn: portNumber title: title [
	^  (self bridgeForAppClass: self defaultApp)
		startOn: portNumber title: title;
		yourself
]

{ #category : #'bridge handling' }
PjBridge class >> stop [
	self soleBridge
		ifNotNil: [ self soleBridge stop.
			self soleBridge: nil.
			Smalltalk garbageCollect ]
]

{ #category : #activity }
PjBridge >> acceptIncomingMessageFromClient: aMessage [
	<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	aMessage shouldEvaluateImmediately
		ifTrue: [ aMessage processWithBridge: self.
			monitor critical: [ monitor signal ].
			^ self ].
	monitor
		critical: [ self incomingMessages add: aMessage.
			monitor signal ]
]

{ #category : #'closure handling' }
PjBridge >> blockClosure: aBlockClosure [
	<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	^ self blockClosures
		at: aBlockClosure
		ifAbsentPut: [ | proxy thisArg includeEventTarget|
			(aBlockClosure isKindOf: BlockClosure)
				ifFalse: [ ^ PjJavascriptError signal: 'Must be a BlockClosure' ].
			aBlockClosure hasMethodReturn
				ifTrue: [ ^ PjJavascriptError signal: 'Block cannot have return' ].
			thisArg := aBlockClosure argumentNames
				findFirst: [ :name | name = 'this' ].
			includeEventTarget := thisArg > 0.
			proxy := self
				evalJavascript:
					self websocketDelegateClassName , '.'
						, transpiler pharoJsSelectorPrefix , 'default().'
						, transpiler pharoJsSelectorPrefix , 'makeBlockClosureProxy_('
						, includeEventTarget asString , ')'.
			proxy closure: aBlockClosure.
			proxy ]
		
]

{ #category : #'closure handling' }
PjBridge >> blockClosures [
	^ blockClosures ifNil: [blockClosures := IdentityDictionary new]
]

{ #category : #accessing }
PjBridge >> client [
	^ client
]

{ #category : #accessing }
PjBridge >> client: aClient [
	client := aClient.
	client initializeWithBridge:  self.
	transpiler := aClient exporter transpiler.

]

{ #category : #initialization }
PjBridge >> clientTitle [
	^self client title
]

{ #category : #public }
PjBridge >> convertToJs: anObject [
	^self exporter convertToJs: anObject
]

{ #category : #accessing }
PjBridge >> defaultClientClass [
	^self class defaultClientClass
]

{ #category : #'closure handling' }
PjBridge >> deleteBlockClosure: aBlockClosure [
	self blockClosures removeKey: aBlockClosure ifAbsent: [  ]
]

{ #category : #'bridge handling' }
PjBridge >> deleteJsValue: jsName [
	"Called by proxy finalizer see methode PjProxy>>jsName:onBridge:"

	self proxies removeKey: jsName ifAbsent: [  ].
	self isServerStopped
		ifTrue: [ ^ self ].
	self sendMessage: (PjMessageDeleteGlobalVar newForVarName: jsName).
	^ proxies
]

{ #category : #evaluating }
PjBridge >> disableWriteDnuDuring: aBlockClosure [ 
	^self transpiler disableWriteDnuDuring: aBlockClosure 
]

{ #category : #evaluating }
PjBridge >> dnuJsString [
	^self transpiler dnuJsString
]

{ #category : #initialization }
PjBridge >> doInNewFrame: aBlock [
	frames add: OrderedCollection new.
	aBlock value.
	frames removeLast.
]

{ #category : #public }
PjBridge >> enableClientLogging [
	self client: self client withClientLogging
]

{ #category : #public }
PjBridge >> evalBlock: aBlock [
	^self evalJavascript: (self convertToJs: aBlock asValuedBlock)

]

{ #category : #public }
PjBridge >> evalJavascript: javaScriptString [
	<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	| msg resultForSentMessage |
	self isConnected
		ifFalse: [ ^ nil ].
	msg := PjMessageEvaluate newWithContents: javaScriptString.
	self sendMessage: msg.
	monitor
		critical: [ monitor
				waitUntil: [ (self incomingResponseMessageForSentMessage: msg) notNil ] ].
	resultForSentMessage := self resultForSentMessage: msg.
	self executeCallbacksUntilDepletion.
	^ resultForSentMessage
]

{ #category : #public }
PjBridge >> evalJavascriptWithDnuFrom: aBlock [
	| jsBlockCode jsDnuCode |
	jsBlockCode := self disableWriteDnuDuring: aBlock.
	jsDnuCode := self dnuJsString.
	^self evalJavascript: jsDnuCode, jsBlockCode

]

{ #category : #public }
PjBridge >> evalMessage: jsMessage [
	^self evalJavascriptWithDnuFrom: [self convertToJs: jsMessage].

]

{ #category : #public }
PjBridge >> evalMessage: aMessage sentTo: receiverName [
	| jsMessage |
	jsMessage := PjJavascriptMessage receiverId: receiverName selector: aMessage selector arguments: aMessage arguments.
	^self evalMessage: jsMessage

]

{ #category : #evaluating }
PjBridge >> evalResponseMessage: aPjMessage [
	^ self
		evalResult: aPjMessage contents
		parsed: aPjMessage contentsObject
]

{ #category : #evaluating }
PjBridge >> evalResult: aString parsed: value [
	value isLiteral ifTrue: [ ^ value ].
	value isNumber ifTrue: [ ^ value ].
	value isDictionary ifTrue: [ value isEmpty ifTrue: [ ^nil ] ].
	(value isKindOf: PjProxyInfo ) ifTrue: [ ^value proxyForBridge: self ].
	value at: #keys ifPresent: [ : map |
		^ map collect: [ : val | self evalResult: aString parsed: val ] ].
	value at: #exception ifPresent: [: message | ^ [ PjJavascriptError signal: message ] ].
	self halt.
	^ [ PjJavascriptError signal: 'unrecognized response from browser:' , aString ]
]

{ #category : #activity }
PjBridge >> executeCallbacksUntilDepletion [
	<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	[ self takeNextCallbackFromIncomingMessages
		ifNil: [ ^ self ]
		ifNotNil: [ :cb | self doInNewFrame: [cb processCallbackWithBridge: self] ] ] repeat
]

{ #category : #accessing }
PjBridge >> exporter [
	^self client exporter
]

{ #category : #accessing }
PjBridge >> incomingMessages [
	^frames last
]

{ #category : #evaluating }
PjBridge >> incomingResponseMessageForSentMessage: aMsg [
	^ self incomingMessages
		detect: [ :msg | msg inResponseToId = aMsg id and: [ msg isCallback not ] ] ifNone: [ nil ]
]

{ #category : #initialization }
PjBridge >> initialize [
	super initialize.
	frames := OrderedCollection with: OrderedCollection new.
	runOnPharo := false.
	shouldStartJsInterpreter := true.
	self server: self serverClass new.
	self finalizationRegistry
		add: self
		executor:
			(ObjectFinalizer new
				receiver: self server;
				selector: #stop;
				yourself).
	communicationTrialsCount := 100.
	monitor := Monitor new
]

{ #category : #accessing }
PjBridge >> initializeWithAppClass: aPharoJsAppClass [
	self client initializeWithAppClass: aPharoJsAppClass.
	self client initializeWithBridge: self.

]

{ #category : #activity }
PjBridge >> isClientIdReceived [
	^ self client clientId notNil
]

{ #category : #public }
PjBridge >> isConnected [
	self webSocket ifNil: [ ^false ].
	^self webSocket isConnected
]

{ #category : #public }
PjBridge >> isListening [
	^self server isListening
]

{ #category : #public }
PjBridge >> isServerStarted [
	^self server isStarted
]

{ #category : #public }
PjBridge >> isServerStopped [
	^self server ifNil: [true] ifNotNil: [self server isStarted not]
]

{ #category : #public }
PjBridge >> loadAllClasses: classes [
	| javaScriptClassesDefinition |
	javaScriptClassesDefinition := self exporter convertAllClassesToJs: classes.
	self evalJavascript: javaScriptClassesDefinition.
	^classes

]

{ #category : #public }
PjBridge >> loadClass: aClass [
	self loadAllClasses: {aClass}.
	^aClass
	
]

{ #category : #activity }
PjBridge >> minimumStepDuration [
	^ 25 milliSeconds
]

{ #category : #activity }
PjBridge >> openOn: portNumber [
	self openOn: portNumber title: 'PharoJS'
]

{ #category : #activity }
PjBridge >> openOn: portNumber test: aTestCase [
	^self openOn: portNumber title: (self titleForTest: aTestCase)
]

{ #category : #activity }
PjBridge >> openOn: portNumber title: title [
	| clientGenerator |
	clientGenerator := self client codeGenerator.
	title ifNotNil: [ clientGenerator titleString: title ].
	self port: portNumber
]

{ #category : #accessing }
PjBridge >> port [
	^self server port
]

{ #category : #initialization }
PjBridge >> port: portNumber [
	self server port: portNumber
]

{ #category : #accessing }
PjBridge >> proxies [
	^ proxies ifNil: [proxies := WeakValueDictionary new]
]

{ #category : #public }
PjBridge >> resetClient [
	| oldWebSocket |
	oldWebSocket := self webSocket.
	self sendMessage: PjMessageReload new.
	self resetProxiesImmediately.
	self client reset.
	"self
		when: [ self webSocket ~~ oldWebSocket ]
		do: [ oldWebSocket isConnected
				ifTrue: [ oldWebSocket close ] ]
		onTimeOutDo: [ self error: 'Client did NOT reconnect!' ]
		timeOutDuration: self client startTimeout."
	self waitForClientToStart
]

{ #category : #initialization }
PjBridge >> resetProxiesImmediately [
	"Leaving this to garbage collection leads to inpredictable results,
	because finalizations might occur in a next (reloaded) client JS session"
	self proxies
		do: [ :v | 
			(self finalizationRegistry remove: v ifAbsent: [ nil ])
				ifNotNil: [ :finalizerItem | "finalizerItem finalizeValues"
					"For now, NOT executing the finalizations (which sends delete proxy messages to the client), because of unknown problems.
					This should be made synchronous anyway by waiting for acknowledgement from client.
					For now, removing them (inactivating) is enough, we only execute this method when we no further need the client."
					].
			true ].
	proxies := nil.
	"Smalltalk garbageCollect. "
]

{ #category : #public }
PjBridge >> restart [
	self stop.
	self start
]

{ #category : #activity }
PjBridge >> resultForSentMessage: sentMsg [
	<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	<T000322Sweep1>
	(self incomingResponseMessageForSentMessage: sentMsg)
		ifNotNil: [ :incMsg | 
			| result2 |
			self incomingMessages remove: incMsg.
			result2 := self evalResponseMessage: incMsg.
			result2 := result2 isClosure
				ifTrue: [ result2 value ]
				ifFalse: [ result2 ].
			^ result2 ].
	self error: 'this should not happen'
]

{ #category : #activity }
PjBridge >> sendMessage: aMessage [
	"self
		when: [ self isConnected ]
		do: []
		onTimeOutDo: [ self inform: 'WebSocket is NOT available' ]
		timeOutDuration: 100 milliSeconds."

	[ self webSocket
		ifNotNil: [ :ws | 
			ws sendMessage: aMessage asPhxJsonString.
			self server logSocketWritten: aMessage logDescription ] ]
		on: Error
		do: [ :ex | ex return ]
]

{ #category : #accessing }
PjBridge >> server [
	^server
]

{ #category : #accessing }
PjBridge >> server: aServer [
	server := aServer.
	aServer ifNotNil: [aServer bridge: self]
]

{ #category : #accessing }
PjBridge >> serverAddress [
	self shouldBeImplemented.
]

{ #category : #initialization }
PjBridge >> serverClass [
	^PjBridgeServer
]

{ #category : #accessing }
PjBridge >> serverUrl [
	^ self server url
]

{ #category : #accessing }
PjBridge >> serverUrl: aString [
	^ self server serverUrl: aString
]

{ #category : #accessing }
PjBridge >> serverUrlString [
	^ self server urlString
]

{ #category : #public }
PjBridge >> setExtraBindings: aDictionary [
	^self exporter setExtraBindings: aDictionary
]

{ #category : #accessing }
PjBridge >> shouldStartJsInterpreter [
	^ shouldStartJsInterpreter
]

{ #category : #accessing }
PjBridge >> shouldStartJsInterpreter: aBoolean [
	shouldStartJsInterpreter := aBoolean
]

{ #category : #public }
PjBridge >> start [
	self startWithoutWaitingForClient.
	self waitForClientToStart.

]

{ #category : #public }
PjBridge >> startJsInterpreter [
	self client startJsInterpreter.
	self waitForClientToStart.
]

{ #category : #activity }
PjBridge >> startOn: portNumber title: title [
	self openOn: portNumber title: title.
	self start
]

{ #category : #public }
PjBridge >> startWithoutWaitingForClient [
	self server start.
	self client start
]

{ #category : #public }
PjBridge >> stop [
	self client stop.
	self server ifNotNil: [self server stop].

]

{ #category : #activity }
PjBridge >> takeNextCallbackFromIncomingMessages [
	<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	self incomingMessages
		detect: [ :msg | msg isCallback ]
		ifFound: [ :cb | 
			self incomingMessages remove: cb.
			^ cb ]
		ifNone: [ ^ nil ]
]

{ #category : #public }
PjBridge >> tearDown [
	self stop.
	self server
		ifNotNil: [ self server tearDown.
			self server: nil ]
]

{ #category : #public }
PjBridge >> terminateClient [
	self isConnected ifFalse: [ ^self ].  
	self client stop.
	self webSocket close.

]

{ #category : #evaluating }
PjBridge >> timeout [
	^ timeout ifNil: [ 10 seconds ]
]

{ #category : #evaluating }
PjBridge >> timeout: aDuration [
	timeout := (aDuration isKindOf: Duration) ifTrue: [ aDuration ] ifFalse: [ aDuration seconds ].
]

{ #category : #initialization }
PjBridge >> titleForTest: aTest [
	^ aTest className , '>>#' , aTest selector
]

{ #category : #accessing }
PjBridge >> transpiler [
	^self exporter transpiler
]

{ #category : #activity }
PjBridge >> waitForClientToStart [
	self waitForClientToStartFor: self client startTimeout
]

{ #category : #activity }
PjBridge >> waitForClientToStartFor: time [
	monitor
		critical: [ monitor
				waitUntil: [ self isClientIdReceived ]
				maxMilliseconds: time asMilliSeconds ].
	self isClientIdReceived
		ifFalse: [ self error: 'Javascript interpreter NOT available' ]
]

{ #category : #activity }
PjBridge >> waitForClientToStartFor: time doing: aBlock [
	self 
		when: [aBlock value. self isConnected] 
		do: [^self] 
		onTimeOutDo: [self error: 'Javascript interpreter NOT available']
		timeOutDuration: time
]

{ #category : #accessing }
PjBridge >> webSocket [
	^self server webSocket
]

{ #category : #accessing }
PjBridge >> webSocketUrlTag [
	^self server webSocketUrlTag
]

{ #category : #initialization }
PjBridge >> websocketDelegateClassName [
	^self client websocketDelegateClassName
]

{ #category : #activity }
PjBridge >> when: conditionBlock do: actionBlock onTimeOutDo: failureBlock timeOutDuration: maxWaitDuration [
	| waitTime |
	waitTime := maxWaitDuration / 100.
	waitTime < self minimumStepDuration ifTrue: [waitTime := self minimumStepDuration].
	100 timesRepeat: [
		conditionBlock value ifTrue: [ ^actionBlock value ].
		waitTime wait.
	].
	^failureBlock value.	

]
