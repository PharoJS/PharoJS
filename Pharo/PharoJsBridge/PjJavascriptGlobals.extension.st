Extension { #name : #PjJavascriptGlobals }

{ #category : #'*PharoJsBridge' }
PjJavascriptGlobals class >> bindingOf: varName [
	| binding |
	binding := super bindingOf: varName.
	binding value ifNotNil: [ ^binding ].
	self initProxyForGlobal: varName.
	^super bindingOf: varName	
]

{ #category : #'*PharoJsBridge' }
PjJavascriptGlobals class >> initProxyForGlobal: varName [
	|newProxy|
	(self classVarNames includes: varName) ifFalse: [ ^self ].
	newProxy := PjProxyForGlobal newProxyNamed: varName.
	self classVarNamed: varName put: newProxy

]
