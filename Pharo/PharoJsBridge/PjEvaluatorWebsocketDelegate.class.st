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

{ #category : #'class initialization' }
PjEvaluatorWebsocketDelegate class >> initialize [
	<javascript:
	'"JSON Math WebSocket console global document history location navigator screen window localStorage module process require".split(" ").forEach(function(s){
		if(this[s]){
			try{Object.defineProperty(this[s],"$_jsName",{value:s,writable:true})}catch(s){};
	}})'>
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
	<javascript:
	'var result;
	try{
		result = Object._resultObject_((function(){return this.eval(aString)})());
	}catch(exception){
		result={exception:exception.message};
	}
	try{
		aString=JSON.stringify(result);
		if(result!=null&&aString=="null") aString=result.toString(); 
		return aString;
	}catch(stringifyException){
		return JSON.stringify({exception:stringifyException.message});
	}'>
]

{ #category : #'initialize-release' }
PjEvaluatorWebsocketDelegate >> initialize [
	super initialize.
	Object prototype instVarNamed: #_inspect putHidden: self makeInspect.

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
	<javascript:
	'
	var self=this;
	function PjBlockClosureProxy(ev){
			callback(PjBlockClosureProxy.$_jsName,ev,this);
			return true;
		};
	function callback(name,ev,jsThis) {
		if (stop) ev.stopPropagation();
		self._doCallBack_(JSON.stringify({cb : [name,
								Object._resultObject_(ev),
								Object._resultObject_(withThis?jsThis:undefined)]}));
	}
	PjBlockClosureProxy.$PjRefCount=0;
	return PjBlockClosureProxy;
	'>
]

{ #category : #'initialize-release' }
PjEvaluatorWebsocketDelegate >> makeInspect [
	<javascript: 'var wsd=this;
	return function(){
		wsd._doCallBack_(JSON.stringify({inspect:Object._resultObject_(this)}));
		return this
	}'>
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
	| aString|
	aString := event data.
	self logReceived: aString.
	aString first = ':' ifTrue: [ ^ self command: aString ].
	self timeout: [
		aString := self eval: aString.
		self isClosed ifFalse: [webSocket send: aString].
		self logSent: aString
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
