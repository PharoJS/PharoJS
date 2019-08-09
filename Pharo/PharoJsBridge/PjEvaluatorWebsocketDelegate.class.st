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

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate class >> eval_jsGenerator [
	<pharoJsSkip>
	^'var result;
	try{
		result = Object.', PjTranspiler pharoJsSelectorPrefix,'resultObject_((function(){return this.eval(aString)})());
	}catch(exception){
		result={exception:exception.message};
	}
	try{
		aString=JSON.stringify(result);
		if(result!=null&&aString=="null") aString=result.toString(); 
		return aString;
	}catch(stringifyException){
		return JSON.stringify({exception:stringifyException.message});
	}'
]

{ #category : #'class initialization' }
PjEvaluatorWebsocketDelegate class >> initialize [
	<javascript:
	'"JSON Math WebSocket console global document history location navigator screen window localStorage module process require".split(" ").forEach(function(s){
		if(this[s]){
			try{Object.defineProperty(this[s],"$_jsName",{value:s,writable:true})}catch(s){};
	}})'>
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate class >> makeBlockClosureProxy_stopPropagation_jsGenerator [
	<pharoJsSkip>
	|prefix|
	prefix := PjTranspiler pharoJsSelectorPrefix.
	^'
	var self=this;
	function PjBlockClosureProxy(ev){
			callback(PjBlockClosureProxy.$_jsName,ev,this);
			return true;
		};
	function callback(name,ev,jsThis) {
		if (stop) ev.stopPropagation();
		self.', prefix, 'doCallBack_(JSON.stringify({cb : [name,
								Object.', prefix, 'resultObject_(ev),
								Object.', prefix, 'resultObject_(withThis?jsThis:undefined)]}));
	}
	PjBlockClosureProxy.$PjRefCount=0;
	return PjBlockClosureProxy;
	'
]

{ #category : #'initialize-release' }
PjEvaluatorWebsocketDelegate class >> makeInspect_jsGenerator [
	<pharoJsSkip>
	^'var wsd=this;
	return function(){
		wsd.', PjTranspiler pharoJsSelectorPrefix, 'doCallBack_(JSON.stringify({inspect:Object.', PjTranspiler pharoJsSelectorPrefix, 'resultObject_(this)}));
		return this
	}'
]

{ #category : #'defaut instance' }
PjEvaluatorWebsocketDelegate class >> reload [
	self closeDefault.
	location reload: true.
	
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
PjEvaluatorWebsocketDelegate class >> set: anObject callback: aString to: callback [
	<javascript:
	'aString="on"+aString;
	console.log(aString);
	var old=anObject[aString];
	console.log(callback);
	console.log(typeof callback);
	console.log(old);
	anObject[aString]=callback;
	console.log(anObject[aString]);
	if (callback && callback.hasOwnProperty("$PjRefCount")) {
		++callback.$PjRefCount;
	}
	if (old && old.$PjRefCount && --old.$PjRefCount==0) {
		old.$PjProxyRemove = true;
		return old;
	}
	return true;
	'>
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

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> command: aString [
	<javascript:
	'var top = (function(){return this})(),
		match = aString.match(/^:(.)((\$_)?.*)/),
		op = match[1],
		name = match[2],
		obj = top[name];
	if (obj && op=="-") {
		obj.$_jsName = undefined;
		if (match[2])
			delete top[name]
	}'>
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> connectTo: urlString [
	shouldRetryToConnectToServer := true.
	bridgeUrlString := urlString.
	super connectTo: urlString
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> doCallBack: aResult [
	webSocket send: aResult.
	self logSent: aResult
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> eval: aString [
	<jsGenerator: #eval_jsGenerator>
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
	<jsGenerator: #makeBlockClosureProxy_stopPropagation_jsGenerator>
]

{ #category : #'initialize-release' }
PjEvaluatorWebsocketDelegate >> makeInspect [
	<jsGenerator: #makeInspect_jsGenerator>
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
	| messageArray messageId messageContent result response |
	messageArray := event data.
	messageId := messageArray first.
	messageContent := messageArray last.
	self logReceived: messageArray.
	messageContent first = ':' ifTrue: [
			self command: messageContent.
			^self timeout: [
					response := Array with: messageId with: nil.
					self isClosed ifFalse: [webSocket send: response].
					self logSent: response  ] 
				for: 0
			].
	self timeout: [
		result := self eval: messageContent.
		response := Array with: messageId with: result.
		self isClosed ifFalse: [webSocket send: response].
		self logSent: response
	] for: 0
]

{ #category : #connecting }
PjEvaluatorWebsocketDelegate >> reconnect [
	shouldRetryToConnectToServer ifFalse: [^ self ].
	super connectTo: bridgeUrlString
]

{ #category : #'socket behavior' }
PjEvaluatorWebsocketDelegate >> timeout: aBlock for: milliseconds [
	<javascript: 'setTimeout(aBlock,milliseconds)'>
]
