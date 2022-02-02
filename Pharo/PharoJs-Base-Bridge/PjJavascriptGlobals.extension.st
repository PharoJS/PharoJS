Extension { #name : #PjJavascriptGlobals }

{ #category : #'*PharoJs-Base-Bridge' }
PjJavascriptGlobals class >> ensureProxyForGlobal: varName [

	| binding |
	binding := super localBindingOf: varName.
	binding value ifNotNil: [ ^ binding ].
	self initProxyForGlobal: varName
]

{ #category : #'*PharoJs-Base-Bridge' }
PjJavascriptGlobals class >> initProxyForGlobal: varName [

	| newProxy |
	(self classVarNames includes: varName) ifFalse: [ ^ self ].
	newProxy := PjProxyForGlobal newProxyNamed: varName.
	self classVarNamed: varName put: newProxy
]

{ #category : #'*PharoJs-Base-Bridge' }
PjJavascriptGlobals class >> localBindingOf: varName [

	self ensureProxyForGlobal: varName.
	^ super localBindingOf: varName
]
