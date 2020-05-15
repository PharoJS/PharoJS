"
A PjEvaluatorWebSocketDelegate is a wrapper for websocket that evaluates received JavaScript code (see onMessage: ). It allows the bridge to control the client (see PjBridge>>#eval:).

In production, the code of this class is translated to javascript and run on the client side.



"
Class {
	#name : #PjEvaluatorWebsocketDelegate,
	#superclass : #PjWebsocketDelegate,
	#instVars : [
		'bridgeUrlString',
		'shouldRetryToConnectToServer'
	],
	#classInstVars : [
		'default'
	],
	#category : #'PharoJsBridge-Client-WebSocketDelegate'
}

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> closeDefault [
	self default close.

]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> connectDefaultToTag: tagString [ 
	| newInstance |
	newInstance := self connectToTag: tagString.
	self default: newInstance 
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> connectDefaultToUrl: urlString [
	| newInstance |
	newInstance := self connectToUrl: urlString.
	self default: newInstance 
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> default [
	^default
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> default: newInstance [
	default := newInstance.

]

{ #category : #constants }
PjEvaluatorWebsocketDelegate class >> includeClasses [
	^ {PhxJsonReader.
	PjMessageDeleteGlobalVar.
	PjMessageEvaluate.
	PjMessageReload.
	PjMessageTerminate}
]

{ #category : #'class initialization' }
PjEvaluatorWebsocketDelegate class >> initialize [
	<javascript:
	'"JSON Math WebSocket console global document history location navigator screen window localStorage module process require".split(" ").forEach(function(s){
		if(global[s]){
			try{Object.defineProperty(global[s],"$_jsName",{value:s,writable:true})}catch(s){};
	}})'>
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> reload [
	self reload: true.
	
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> reload: aBoolean [
	self closeDefault.
	"Reload parameter specifies the type of reloading:
false - Default. Reloads the current page from the cache.
true - Reloads the current page from the server."
	location reload: aBoolean.
	
]

{ #category : #'proxy support' }
PjEvaluatorWebsocketDelegate class >> set: anObject callback: trigger to: callback [
<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	| fullTriggerName oldCallback |
	fullTriggerName := 'on' , trigger.
	oldCallback := anObject instVarNamed: fullTriggerName.
	anObject instVarNamed: fullTriggerName put: callback.
	callback
		ifNotNil: [ (callback hasOwnProperty: '$PjRefCount')
				ifTrue: [ | currRefCnt |
					currRefCnt := callback instVarNamed: '$PjRefCount'.
					callback instVarNamed: '$PjRefCount' put: currRefCnt + 1 ] ].
	oldCallback
		ifNotNil: [ | currRefCnt |
			currRefCnt := oldCallback instVarNamed: '$PjRefCount'.
			currRefCnt > 0
				ifTrue: [ oldCallback instVarNamed: '$PjRefCount' put: currRefCnt - 1.
					(oldCallback instVarNamed: '$PjRefCount') == 0
						ifTrue: [ oldCallback instVarNamed: '$PjProxyRemove' put: true.
							^ oldCallback ] ] ].
	^ true
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> terminate [ 
	[ self closeDefault ]
		on: Error
		do: [  ].
	[ process exit ]
		on: Error
		do: [  ]
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> close [
	shouldRetryToConnectToServer := false.
	super close
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> connectTo: urlString [
	shouldRetryToConnectToServer := true.
	bridgeUrlString := urlString.
	super connectTo: urlString
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> doCallBack: aResult [
	webSocket
		send: (PjMessageResponse newWithContents: aResult) asPhxJsonString.
	self logSent: aResult
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> evalSafe: aString [
	"<jsGenerator: #eval_jsGenerator:>"
	| resultObject resultString |
	resultObject := [ Object resultObject: (global eval: aString) ]
		on: Error
		do: [ :ex | {('exception' -> ex message)} asDictionary ].
	^ [ resultString := JSON stringify: resultObject.
	resultObject
		ifNotNil: [ resultString = 'null'
				ifTrue: [ resultString := resultObject toString ] ].
	resultString ifNil: [ resultString := 'null' ].
	resultString ]
		on: Error
		do: [ :ex | ex return: {('exception' -> ex message)} asDictionary ]
]

{ #category : #'initialize-release' }
PjEvaluatorWebsocketDelegate >> initialize [
	super initialize.
	Object prototype instVarNamed: PjCore pharoJsSelectorPrefix, 'inspect' putHidden: self makeInspect.

]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> logReceived: aString [
	console log: 'Received: ',aString
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> logSent: aString [
	console log: 'Sent: ',aString
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> makeBlockClosureProxy: withThis [
	^ self makeBlockClosureProxy: withThis stopPropagation: true
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> makeBlockClosureProxy: withThis stopPropagation: stop [
	"<jsGenerator: #makeBlockClosureProxy_stopPropagation_jsGenerator:>"

		<PhxTicket: 'T#000322' name: 'Refactoring ParoJs PjBridge'>
	<javascript:
		'
	var self=this;
	function PjBlockClosureProxy(ev){
			callback(PjBlockClosureProxy.$_jsName,ev,this);
			return true;
		};
	function callback(name,ev,jsThis) {
		if (stop) ev.stopPropagation();
		self.pj_doCallBack_(JSON.stringify({cb : [name,
								Object.pj_resultObject_(ev),
								Object.pj_resultObject_(withThis?jsThis:undefined)]}));
	}
	PjBlockClosureProxy.$PjRefCount=0;
	return PjBlockClosureProxy;
	'>

	| b |
	b := [ :ev | 
	[ :name :ev2 :jsThis | 
	| cbPayload cb |
	stop
		ifTrue: [ ev2 stopPropagation ].
	cbPayload := {name.
	ev2 proxyResponse.
	(withThis
		ifFalse: [ nil ]
		ifTrue: [ jsThis proxyResponse ])}.
	cb := {('cb' -> cbPayload)} asDictionary.
	self doCallBack: (JSON stringify: cb) ].
	true ].
	b instVarNamed: '$PjRefCount' put: 0.
	^ b
]

{ #category : #'initialize-release' }
PjEvaluatorWebsocketDelegate >> makeInspect [
"	<pharoJsSkip>
	^'var wsd=this;
	return function(){
		wsd.', transpiler pharoJsSelectorPrefix, 'doCallBack_(JSON.stringify({inspect:Object.', transpiler pharoJsSelectorPrefix, 'resultObject_(this)}));
		return this
	}'"

	^[self
		doCallBack: (JSON stringify: {('inspect' -> self proxyResponse)} asDictionary)]
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> onClose: event [
	self reconnect
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> onError: event [
	self reconnect
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> onMessage: event [
	| jsonString msg |
	jsonString := event data.
	msg := PhxJsonReader readFromString: jsonString.
	self logReceived: msg logDescription.
	msg evaluateInContext: self newMessageContext
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> reconnect [
	shouldRetryToConnectToServer ifFalse: [^ self ].
	super connectTo: bridgeUrlString
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> tryToSendMessage: aMessage [
	self isClosed
		ifTrue: [ self logSent: 'Failed to send (websocket closed): ' , aMessage logDescription ]
		ifFalse: [ webSocket send: aMessage asPhxJsonString.
			self logSent: aMessage logDescription ]
]
