Class {
	#name : #PjInfrastructureTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsBridge-Tests'
}

{ #category : #testing }
PjInfrastructureTest >> testCallGetsTrampolined [
	self assert: (bridge evalBlock: [nil~=(document getElementsByTagName: 'script')])
]

{ #category : #testing }
PjInfrastructureTest >> testDNUSetup [
	self assert: (bridge evalJavascript: 'undefined === document._children').
	self assert: (bridge evalBlock: [document children ~= nil]).
	self assert: (bridge evalJavascript: 'window._children !== document._children').
	self assert: (bridge evalJavascript: 'window._children !== undefined').
	self assert: (bridge evalJavascript: 'window._children === console._children').
	self assert: (bridge evalJavascript: 'HTMLDocument.prototype._children === document._children')
]

{ #category : #testing }
PjInfrastructureTest >> testGetterGetsTrampolined [
	self assert: (bridge evalBlock: [document body ~= nil])
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
	self assert: [PjCore makeJavascriptSelector: #foo] evaluatesTo: '_foo'.
	self assert: [PjCore makeJavascriptSelector: #foo:] evaluatesTo: '_foo_'.
	self assert: [PjCore makeJavascriptSelector: #,] evaluatesTo: '_44_'.
	self assert: [PjCore makeJavascriptSelector: #_44_] evaluatesTo: '_44_'.
	self assert: [PjCore makeJavascriptSelector: #_foo] evaluatesTo: '_foo'.
	self assert: [PjCore makeJavascriptSelector: #_foo_] evaluatesTo: '_foo_'.

]

{ #category : #testing }
PjInfrastructureTest >> testSTSelector [
	self assert: [PjCore makeSmalltalkSelector: #foo] evaluatesTo: 'foo'.
	self assert: [PjCore makeSmalltalkSelector: #foo:] evaluatesTo: 'foo:'.
	self assert: [PjCore makeSmalltalkSelector: #,] evaluatesTo: ','.
	self assert: [PjCore makeSmalltalkSelector: #_44_] evaluatesTo: ','.
	self assert: [PjCore makeSmalltalkSelector: #_foo] evaluatesTo: 'foo'.
	self assert: [PjCore makeSmalltalkSelector: #_foo_] evaluatesTo: 'foo:'.

]

{ #category : #testing }
PjInfrastructureTest >> testSetterGetsTrampolined [
	bridge evalBlock: [document js_at: 'foo' put: 17].
	bridge evalBlock: [document foo: 42].
	self assert: (bridge evalBlock: [document foo = 42])
]

{ #category : #testing }
PjInfrastructureTest >> testValueNonInterference [
	self addToDOM: '<input id="theInput" type="text" value="Name:">'.
	self assert: [|t| t:=document getElementById: #theInput.t value=t defaultValue] evaluatesTo: true.
	self assert: [|t| t:=document getElementById: #theInput.t value: 'addr'] evaluatesTo: 'addr'.
	self assert: [|t| t:=document getElementById: #theInput.t value] evaluatesTo: 'addr'
]
