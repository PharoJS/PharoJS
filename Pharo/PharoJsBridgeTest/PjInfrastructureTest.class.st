Class {
	#name : #PjInfrastructureTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsBridgeTest-Tests'
}

{ #category : #testing }
PjInfrastructureTest >> testCallGetsTrampolined [
	self
		assert:
			(self bridge
				evalBlock: [ nil ~= (document getElementsByTagName: 'script') ])
]

{ #category : #testing }
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

{ #category : #testing }
PjInfrastructureTest >> testEvaluatorWebsockerDelegateId [


		self bridge sendMessage: PjMessageReload new.
]

{ #category : #testing }
PjInfrastructureTest >> testGetterGetsTrampolined [
	self assert: (self bridge evalBlock: [ document body ~= nil ])
]

{ #category : #testing }
PjInfrastructureTest >> testIs [
	self assertEquivalent: [Object isBlock].
	self assertEquivalent: [Object new isBlock].
	self assertEquivalent: [Object isBlock].
	self assertEquivalent: [[] isBlock].
	self assertEquivalent: [Object new isClass].
	self assertEquivalent: [[] isClass].
	self assertEquivalent: [Object isBehavior].
	self assertEquivalent: [Object isClass].

]

{ #category : #testing }
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

{ #category : #testing }
PjInfrastructureTest >> testSTSelector [
	self assert: [PjCore makeSmalltalkSelector: #foo] evaluatesTo: 'foo'.
	self assert: [PjCore makeSmalltalkSelector: #foo:] evaluatesTo: 'foo:'.
	self assert: [PjCore makeSmalltalkSelector: #,] evaluatesTo: ','.
	self assert: [PjCore makeSmalltalkSelector: PjCore pharoJsSelectorPrefix, '44_'] evaluatesTo: ','.
	self assert: [PjCore makeSmalltalkSelector: PjCore pharoJsSelectorPrefix, 'foo'] evaluatesTo: 'foo'.
	self assert: [PjCore makeSmalltalkSelector: PjCore pharoJsSelectorPrefix, 'foo_'] evaluatesTo: 'foo:'.

]

{ #category : #testing }
PjInfrastructureTest >> testSetterGetsTrampolined [
	self bridge evalBlock: [ document js_at: 'foo' put: 17 ].
	self bridge evalBlock: [ document foo: 42 ].
	self assert: (self bridge evalBlock: [ document foo = 42 ])
]

{ #category : #testing }
PjInfrastructureTest >> testValueNonInterference [
	self addToDOM: '<input id="theInput" type="text" value="Name:">'.
	self assert: [|t| t:=document getElementById: #theInput.t value=t defaultValue] evaluatesTo: true.
	self assert: [|t| t:=document getElementById: #theInput.t value: 'addr'] evaluatesTo: 'addr'.
	self assert: [|t| t:=document getElementById: #theInput.t value] evaluatesTo: 'addr'
]
