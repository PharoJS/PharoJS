Class {
	#name : #PjInfrastructureTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #tests }
PjInfrastructureTest >> testAccessorForClass [

	| a jsObject |
	jsObject :=  self evalBlock: [ Object].
	a := self evalBlock: [ { (#x -> Object) } asJsObject ].
	self assert: a x identicalTo: jsObject.
	a x: 111.
	self assert: a x equals: 111.

]

{ #category : #tests }
PjInfrastructureTest >> testAccessorInstalledOnClass [

	| a b |
	b := self evalBlock: [ PjBSubClassOfA ].
	a := self evalBlock: [ PjASuperClass ].
	b instVarNamed: #y put: 0.
	b y: 222.
	self assert: b y equals: 222.
	{
		[ a y ].
		[ a y: 444 ] } do: [ :aBlock | self should: aBlock raise: Error ]
]

{ #category : #tests }
PjInfrastructureTest >> testAccessorInstalledOnObject [

	| a b |
	a := self evalBlock: [ { (#x -> 0) } asJsObject ].
	self assert: a jsClassName equals: #Object.
	a x: 111.
	self assert: a x equals: 111.
	b := self evalBlock: [ { (#y -> 0) } asJsObject ].
	self assert: b jsClassName equals: #Object.
	b y: 222.
	self assert: b y equals: 222.
	{
		[ b x ].
		[ b x: 333 ].
		[ a y ].
		[ a y: 444 ] } do: [ :aBlock | self should: aBlock raise: Error ]
]

{ #category : #tests }
PjInfrastructureTest >> testAccessorInstalledOnPrototype [

	| a b |
	a := self evalBlock: [ PjASuperClass new ].
	a instVarNamed: #x put: nil.
	a x: 111.
	self assert: a x equals: 111.
	self should: [ a y ] raise: Error.
	b := self evalBlock: [ PjASuperClass new ].
	self assert: b x isNil.
	b instVarNamed: #y put: nil.
	b y: 222.
	self assert: b y equals: 222.
	self assert: a y isNil.

]

{ #category : #tests }
PjInfrastructureTest >> testBridgePort [

	self assert: self bridge port equals: self bridge server port
]

{ #category : #tests }
PjInfrastructureTest >> testBugDnuInstallsSetterInsteadOfGetter [

	self assertBlock: [
			 | o |
			 o := Object new.
			 o at: 'someProp' put: nil.
			 o someProp. "this should make a getter and not a setter"
			 o at: 'someProp' put: 10.
			 o someProp = 10 ]
]

{ #category : #tests }
PjInfrastructureTest >> testCallGetsTrampolined [

	self assert: (self bridge evalBlock: [ 
			 nil ~= (document getElementsByTagName: 'script') ])
]

{ #category : #tests }
PjInfrastructureTest >> testDNUInstallsAGetterAndNotASetter [
    self assert: (self bridge evalBlock: [
             | obj |
             obj := Object new.
             obj instVarNamed: 'someProp' put: nil.
             obj someProp. "this should install a getter, but a setter method gets installed instead, because the value of someProp is nil"
             obj instVarNamed: 'someProp' put: 10.
             console log: 'someProp =' with: obj someProp. "Observe in console log that 'obj someProp' returns nil, instead of 10"
             obj someProp = 10 ])
]

{ #category : #tests }
PjInfrastructureTest >> testDNUSetup [

	| prefix |
	prefix := self bridge exporter transpiler pharoJsSelectorPrefix.
	self
		assert: (self bridge evalJavascript: 'undefined === document.', prefix, 'children').
	self assert: (self bridge evalBlock: [ document children ~= nil ]).
	self
		assert:
			(self bridge evalJavascript: 'window.', prefix, 'children !== document.', prefix, 'children').
	self
		assert: (self bridge evalJavascript: 'window.', prefix, 'children !== undefined').
	self
		assert: (self bridge evalJavascript: 'window.', prefix, 'children === console.', prefix, 'children').
	self
		assert:
			(self bridge
				evalJavascript: 'HTMLDocument.prototype.', prefix, 'children === document.', prefix, 'children')
]

{ #category : #tests }
PjInfrastructureTest >> testGetterGetsTrampolined [

	self assert: (self bridge evalBlock: [ document body ~= nil ])
]

{ #category : #tests }
PjInfrastructureTest >> testIs [

	self assertEquivalent: [ Object isBlock ].
	self assertEquivalent: [ Object new isBlock ].
	self assertEquivalent: [ Object isBlock ].
	self assertEquivalent: [ [] isBlock ].
	self assertEquivalent: [ Object new isClass ].
	self assertEquivalent: [ [] isClass ].
	self assertEquivalent: [ Object isBehavior ].
	self assertEquivalent: [ Object isClass ]
]

{ #category : #tests }
PjInfrastructureTest >> testJSSelector [

	|prefix|
	prefix := self bridge exporter transpiler pharoJsSelectorPrefix.
	self assert: [PjCore makePharoJsSelector: #foo] evaluatesTo: prefix, 'foo'.
	self assert: [PjCore makePharoJsSelector: #foo:] evaluatesTo: prefix, 'foo_'.
	self assert: [PjCore makePharoJsSelector: ','] evaluatesTo: prefix, '44_'.
	self assert: [PjCore makePharoJsSelector: prefix, '44_'] evaluatesTo: prefix, '44_'.
	self assert: [PjCore makePharoJsSelector: prefix, 'foo'] evaluatesTo: prefix, 'foo'.
	self assert: [PjCore makePharoJsSelector: prefix, 'foo_'] evaluatesTo: prefix, 'foo_'.
	self assert: [PjCore makePharoJsSelector: #'$foo:'] evaluatesTo: prefix, '$foo_'.
]

{ #category : #tests }
PjInfrastructureTest >> testOpenUrlWithParameters [

	| clientUrl |
	clientUrl := self bridge server url ? (#paramA -> #valueA)
	             & (#paramB -> #valueB).
	self bridge client stop.
	self bridge resetProxiesImmediately.
	self waitWhile: [ self bridge isConnected ] timeOut: 2 seconds.
	self bridge client openWebBrowserOn: clientUrl asString.
	self waitUntil: [ self bridge isConnected ] timeOut: 2 seconds.
	self waitWhile: [ (app := self currentApp) isNil ] timeOut: 2 seconds.
	self assert: location search equals: '?paramA=valueA&paramB=valueB'
]

{ #category : #tests }
PjInfrastructureTest >> testSTSelector [

	self assert: [ PjCore makeSmalltalkSelector: #foo ] evaluatesTo: 'foo'.
	self assert: [ PjCore makeSmalltalkSelector: #foo: ] evaluatesTo: 'foo:'.
	self assert: [ PjCore makeSmalltalkSelector: #, ] evaluatesTo: ','.
	self assert: [ PjCore makeSmalltalkSelector: PjCore pharoJsSelectorPrefix, '44_' ] evaluatesTo: ','.
	self assert: [ PjCore makeSmalltalkSelector: PjCore pharoJsSelectorPrefix, 'foo' ] evaluatesTo: 'foo'.
	self assert: [ PjCore makeSmalltalkSelector: PjCore pharoJsSelectorPrefix, 'foo_' ] evaluatesTo: 'foo:'
]

{ #category : #tests }
PjInfrastructureTest >> testSetterGetsTrampolined [

	self bridge evalBlock: [ document js_at: 'foo' put: 17 ].
	self bridge evalBlock: [ document foo: 42 ].
	self assert: (self bridge evalBlock: [ document foo = 42 ])
]

{ #category : #tests }
PjInfrastructureTest >> testValueNonInterference [

	self addToDOM: '<input id="theInput" type="text" value="Name:">'.
	self assert: [|t| t := document getElementById: #theInput.t value=t defaultValue] evaluatesTo: true.
	self assert: [|t| t := document getElementById: #theInput.t value: 'addr'] evaluatesTo: 'addr'.
	self assert: [|t| t := document getElementById: #theInput.t value] evaluatesTo: 'addr'
]
