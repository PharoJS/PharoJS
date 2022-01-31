Extension { #name : #PjJavascriptGlobals }

{ #category : #'*PharoJsBridge' }
PjJavascriptGlobals class >> ensureProxyForGlobal: varName [
	| binding |
	binding := super localBindingOf: varName.
	binding value ifNotNil: [ ^binding ].
	self initProxyForGlobal: varName.
]

{ #category : #'*PharoJsBridge' }
PjJavascriptGlobals class >> initProxyForGlobal: varName [
	|newProxy|
	(self classVarNames includes: varName) ifFalse: [ ^self ].
	newProxy := PjProxyForGlobal newProxyNamed: varName.
	self classVarNamed: varName put: newProxy
]

{ #category : #'*PharoJsBridge' }
PjJavascriptGlobals class >> localBindingOf: varName [
	self ensureProxyForGlobal: varName.
	^super localBindingOf: varName
]
