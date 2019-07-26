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
	self
		assert: (self bridge evalJavascript: 'undefined === document.', PjTranspiler pharoJsSelectorPrefix, 'children').
	self assert: (self bridge evalBlock: [ document children ~= nil ]).
	self
		assert:
			(self bridge evalJavascript: 'window.', PjTranspiler pharoJsSelectorPrefix, 'children !== document.', PjTranspiler pharoJsSelectorPrefix, 'children').
	self
		assert: (self bridge evalJavascript: 'window.', PjTranspiler pharoJsSelectorPrefix, 'children !== undefined').
	self
		assert: (self bridge evalJavascript: 'window.', PjTranspiler pharoJsSelectorPrefix, 'children === console.', PjTranspiler pharoJsSelectorPrefix, 'children').
	self
		assert:
			(self bridge
				evalJavascript: 'HTMLDocument.prototype.', PjTranspiler pharoJsSelectorPrefix, 'children === document.', PjTranspiler pharoJsSelectorPrefix, 'children')
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
	self assert: [PjCore makePharoJsSelector: #foo] evaluatesTo: PjTranspiler pharoJsSelectorPrefix, 'foo'.
	self assert: [PjCore makePharoJsSelector: #foo:] evaluatesTo: PjTranspiler pharoJsSelectorPrefix, 'foo_'.
	self assert: [PjCore makePharoJsSelector: #,] evaluatesTo: PjTranspiler pharoJsSelectorPrefix, '44_'.
	self assert: [PjCore makePharoJsSelector: #_44_] evaluatesTo: PjTranspiler pharoJsSelectorPrefix, '44_'.
	self assert: [PjCore makePharoJsSelector: #_foo] evaluatesTo: PjTranspiler pharoJsSelectorPrefix, 'foo'.
	self assert: [PjCore makePharoJsSelector: #_foo_] evaluatesTo: PjTranspiler pharoJsSelectorPrefix, 'foo_'.
	self assert: [PjCore makePharoJsSelector: #'$foo:'] evaluatesTo: PjTranspiler pharoJsSelectorPrefix, '$foo_'.

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
