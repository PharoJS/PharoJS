"
I am PjBrowserProxy and I provide a Pharo-side proxy for browser-side Javascript objects.

I provide access to Javascript and DOM objects on the browser.
Messages sent to my instances will evaluate on the browser allowing creation and manipulation of Javascript and DOM objects.
This allows development and debugging of programs on Pharo (using the browser as the UI) for subsequent deployment on the browser.

I should become a subclass of ProtoObject, but there are things to be done first, such as implement isNil, the ifNil:s, class, inspect, Nautilus support methods, etc.  In the meantime, if there is a method that should go to the browser, define it like #confirm:

My class has a reference to a PjBrowserBridge which has a connection to the browser so that I can execute code on the browser.

Example: 

1) highlight and do: "" PjProxy startOn: 12345 ""

2) now in a browser open localhost:12345

3) in a Playground, you can now access ""window"", ""document"" (but you cannot do it in the same playground as the startOn:)

4) When you are finished do: "" PjProxy stop ""

Public API and Key Messages

- startOn: - class method to create a port for connection from a browser 
- stop - class method to end the connection

The values window and document are pre-defined PjBrowserProxy  objects.
Any message sent to a PjBrowserProxy object will execute on the browser and return a Smalltalk value - either a primitive value or a PjBrowserProxy object.
  
Internal Representation and Key Implementation Points.

    Class Variables
	bridge:		<PjBrowserBridge> - connection to the browser

    Instance Variables
	jsName:		<String> - browser-side name of the value


    Implementation Points

- finalization of the Smalltalk object deletes the cached value on the browser

"
Class {
	#name : #PjProxy,
	#superclass : #Object,
	#instVars : [
		'jsName',
		'oid',
		'closure',
		'proxySpecificBridge'
	],
	#category : #'PharoJs-Base-Bridge-Proxy'
}

{ #category : #'instance creation' }
PjProxy class >> newProxyNamed: proxyName onBridge: aBridge oid: anOid [
	^ ((proxyName beginsWith: '$_')
		ifTrue: [ PjProxy ]
		ifFalse: [ PjProxyForGlobal ]) new
		jsName: proxyName onBridge: aBridge oid: anOid;
		yourself
]

{ #category : #'instance creation' }
PjProxy class >> proxyNamed: proxyName onBridge: aBridge [
	"Useful for building proxies on JS globals"
	^ self proxyNamed: proxyName onBridge: aBridge oid: proxyName
]

{ #category : #'instance creation' }
PjProxy class >> proxyNamed: proxyName onBridge: aBridge oid: anOid [
	| proxy |
	aBridge
		ifNotNil: [ proxy := aBridge proxies
				detect: [ :p | p oid = anOid ]
				ifNone: [ nil ].
			proxy ifNotNil: [ ^ proxy ].
			proxy := aBridge proxies at: proxyName ifAbsent: [ nil ].
			proxy ifNotNil: [ ^ proxy ].
			proxy := PjProxy
				newProxyNamed: proxyName
				onBridge: aBridge
				oid: anOid.
			^ aBridge proxies at: proxyName put: proxy ]
]

{ #category : #comparing }
PjProxy >> = anObject [

	| equalMessage |
	super == anObject ifTrue: [ ^ true ].
	(anObject isKindOf: PjProxy) ifFalse: [ ^ false ].
	proxySpecificBridge = anObject jsBridge ifFalse: [ ^ false ].
	equalMessage := Message selector: #= argument: anObject.
	^ self jsBridge: [ :bridge | 
		  bridge evalMessage: equalMessage sentTo: jsName ]
]

{ #category : #'reflective operations' }
PjProxy >> addEventListener: type block: aBlock [

	^ self jsBridge: [ :bridge | 
		  | bcProxyInfo msg |
		  bcProxyInfo := aBlock ifNotNil: [ 
			                 (bridge ensureProxyForEventListenerBlock: aBlock)
				                 asProxyInfo ].
		  msg := PjMessageSetEventListener newWithId.
		  msg targetProxyInfo: self asProxyInfo.
		  msg listenerProxyInfo: bcProxyInfo.
		  msg eventName: type.
		  bridge sendMessageAndWaitForResponse: msg ]
]

{ #category : #converting }
PjProxy >> asJSON [

	^ jsName
]

{ #category : #converting }
PjProxy >> asJsObjectUsing: converter [

	^ self
]

{ #category : #converting }
PjProxy >> asLocalObject [

	| size |
	size := self size.
	^ Array
		  new: size
		  streamContents: [ :s | 
		  1 to: size do: [ :index | s nextPut: (self at: index) ] ]
]

{ #category : #converting }
PjProxy >> asRawJSONString [

	^ self jsBridge: [ :bridge | 
		  bridge evalJavascript: 'JSON.stringify(' , jsName , ')' ]
]

{ #category : #'force proxy' }
PjProxy >> at: index [

	^ self doesNotUnderstand: (Message selector: #at: argument: index)
]

{ #category : #'force proxy' }
PjProxy >> at: index put: anObject [

	^ self doesNotUnderstand: (Message selector: #at:put: arguments: { 
				   index.
				   anObject })
]

{ #category : #'closure handling' }
PjProxy >> closure: aBlockClosure [

	closure ifNotNil: [ 
		self jsBridge: [ :bridge | bridge deleteBlockClosure: closure ] ].
	closure := aBlockClosure
]

{ #category : #'force proxy' }
PjProxy >> confirm: aString [

	^ self doesNotUnderstand:
		  (Message selector: #confirm: argument: aString)
]

{ #category : #'reflective operations' }
PjProxy >> convertToJavascriptAstUsing: aPjAstConverter [

	^ PjGlobalNode identifier: jsName
]

{ #category : #'reflective operations' }
PjProxy >> doesNotUnderstand: aMessage [

	^ self jsBridge: [ :bridge | 
		  bridge evalMessage: aMessage sentTo: jsName ]
]

{ #category : #'force proxy' }
PjProxy >> head [

	^ self doesNotUnderstand: (Message selector: #head)
]

{ #category : #introspection }
PjProxy >> instVarNamed: aString [

	^ self jsBridge: [ :bridge | 
		  | selector |
		  selector := jsName , '.' , aString.
		  bridge evalJavascript: selector ]
]

{ #category : #introspection }
PjProxy >> instVarNamed: aString put: aValue [

	^ self jsBridge: [ :bridge | 
		  bridge evalJavascriptWithDnuFrom: [ 
			  jsName , '.' , aString , '=' , (bridge convertToJs: aValue) ] ]
]

{ #category : #testing }
PjProxy >> isLiteralJavascriptValue [

	^ true
]

{ #category : #testing }
PjProxy >> isPjProxyNil [

	jsName = 'undefined' ifTrue: [ ^ true ].
	jsName = 'null' ifTrue: [ ^ true ].
	^ false
]

{ #category : #testing }
PjProxy >> isPjProxyOrNil [

	^ true
]

{ #category : #'javascript generation' }
PjProxy >> javascriptName [

	^ jsName
]

{ #category : #'javascript generation' }
PjProxy >> javascriptValid [

	^ true
]

{ #category : #'force proxy' }
PjProxy >> join: aCollection [

	^ self doesNotUnderstand:
		  (Message selector: #join: argument: aCollection)
]

{ #category : #accessing }
PjProxy >> jsBridge [

	^ proxySpecificBridge
]

{ #category : #accessing }
PjProxy >> jsBridge: aBlock [

	proxySpecificBridge ifNotNil: [ :bridge | ^ aBlock value: bridge ].
	PjBridge soleBridge ifNotNil: [ :bridge | ^ aBlock value: bridge ].
	self error: 'no bridge for proxy: ' , jsName
]

{ #category : #'initialize-release' }
PjProxy >> jsName: aString onBridge: aBridge oid: anOid [

	jsName := aString asSymbol.
	oid := anOid asSymbol.
	aBridge ifNotNil: [ 
		| finalizer |
		finalizer := PjProxyFinalizationHandler
			             finalizerForProxyNamed: jsName
			             onBridge: aBridge.
		self finalizationRegistry add: self executor: finalizer ].
	proxySpecificBridge := aBridge
]

{ #category : #'force proxy' }
PjProxy >> log: aString [

	^ self doesNotUnderstand: (Message selector: #log: argument: aString)
]

{ #category : #'force proxy' }
PjProxy >> name [

	^ self doesNotUnderstand: (Message selector: #name)
]

{ #category : #accessing }
PjProxy >> oid [

	^ oid
]

{ #category : #accessing }
PjProxy >> oid: anObject [

	oid := anObject
]

{ #category : #'javascript generation' }
PjProxy >> printJsOn: aStream [

	aStream nextPutAll: jsName
]

{ #category : #printing }
PjProxy >> printOn: ws [

	super printOn: ws.
	ws << ' (oid: '.
	self oid ifNil: [ ws << '-' ] ifNotNil: [ ws << self oid ].
	ws << ')'
]

{ #category : #'reflective operations' }
PjProxy >> removeEventListener: type [

	^ self addEventListener: type block: nil
]

{ #category : #'closure handling' }
PjProxy >> runBlockClosure: ev with: this [

	closure ifNotNil: [ closure cull: ev cull: this ]
]

{ #category : #'force proxy' }
PjProxy >> size [

	^ self doesNotUnderstand: (Message selector: #size)
]

{ #category : #'force proxy' }
PjProxy >> value [

	^ self doesNotUnderstand: (Message selector: #value)
]

{ #category : #'force proxy' }
PjProxy >> value: anObject [

	^ self doesNotUnderstand:
		  (Message selector: #value: argument: anObject)
]
