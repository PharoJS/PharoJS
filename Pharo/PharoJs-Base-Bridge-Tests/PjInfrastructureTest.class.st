Class {
	#name : 'PjInfrastructureTest',
	#superclass : 'PjBridgeTestCase',
	#category : 'PharoJs-Base-Bridge-Tests-Tests',
	#package : 'PharoJs-Base-Bridge-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PjInfrastructureTest >> testAccessorForClass [

	| a jsObject |
	jsObject :=  self evalBlock: [ Object].
	a := self evalBlock: [ { (#x -> Object) } asJsObject ].
	self assert: a x identicalTo: jsObject.
	a x: 111.
	self assert: a x equals: 111.

]

{ #category : 'tests' }
PjInfrastructureTest >> testAccessorForInheritedPropertyWithNilNilValue [

	| a b xValue otherXValue |
	a := self evalBlock: [ Object new ].
	b := self evalBlock: [ Object new ].
	b instVarNamed: #__proto__ put: a.
	3 timesRepeat: [ self should: [ b xXx ] raise: Error].
	a instVarNamed: #xXx put: nil.
	self assert: b xXx isNil.
	xValue := 'wonderful!'.
	b xXx: xValue.
	self assert: b xXx equals: xValue.
	self assert: a xXx isNil.
	otherXValue := 'somehting else'.
	a xXx: otherXValue.
	self assert: b xXx equals: xValue.
	self assert: a xXx equals: otherXValue
]

{ #category : 'tests' }
PjInfrastructureTest >> testAccessorForIvWithUnderscore [
	| a b |
	a := self evalBlock: [ PjASuperClass new ].
	a instVarNamed: #_x put: nil.
	a _x: 111.
	self assert: a _x equals: 111.
	b := self evalBlock: [ PjASuperClass new ].
	b instVarNamed: #y_y put: nil.
	b y_y: 222.
	self assert: b y_y equals: 222.

]

{ #category : 'tests' }
PjInfrastructureTest >> testAccessorInstalledOnClass [

	| a b |
	b := self evalBlock: [ PjBSubClassOfA ].
	a := self evalBlock: [ PjASuperClass ].
	b instVarNamed: #y put: nil.
	b y: 222.
	self assert: b y equals: 222.
	{
		[ a y ].
		[ a y: 444 ] } do: [ :aBlock | self should: aBlock raise: Error ]
]

{ #category : 'tests' }
PjInfrastructureTest >> testAccessorInstalledOnObject [

	| a b |
	a := self evalBlock: [ { (#x -> nil) } asJsObject ].
	self assert: a jsClassName equals: #Object.
	a x: 111.
	self assert: a x equals: 111.
	b := self evalBlock: [ { (#y -> nil) } asJsObject ].
	self assert: b jsClassName equals: #Object.
	b y: 222.
	self assert: b y equals: 222.
	{
		[ b x ].
		[ b x: 333 ].
		[ a y ].
		[ a y: 444 ] } do: [ :aBlock | self should: aBlock raise: Error ]
]

{ #category : 'tests' }
PjInfrastructureTest >> testAccessorInstalledOnPrototype [
	"JS classes have a property named #prototype which references an object that acts as prototype for other instances. The prototype owns all instance methods."
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

{ #category : 'tests' }
PjInfrastructureTest >> testBridgePort [

	self assert: self bridge port equals: self bridge server port
]

{ #category : 'tests' }
PjInfrastructureTest >> testBugDnuInstallsSetterInsteadOfGetter [

	self assertBlock: [
			 | o |
			 o := Object new.
			 o at: 'someProp' put: nil.
			 o someProp. "this should make a getter and not a setter"
			 o at: 'someProp' put: 10.
			 o someProp = 10 ]
]

{ #category : 'tests' }
PjInfrastructureTest >> testCallGetsTrampolined [

	self assert: (self bridge evalBlock: [ 
			 nil ~= (document getElementsByTagName: 'script') ])
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
PjInfrastructureTest >> testGetterGetsTrampolined [

	self assert: (self bridge evalBlock: [ document body ~= nil ])
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
PjInfrastructureTest >> testSelectorPharoJsToStConversion [

	| prefix |
	prefix := self evalBlock: [ PjCore pharoJsSelectorPrefix ].
	{ #foo -> 'foo'.
	#foo: -> 'foo_'.
	',' -> '44_'.
	'$foo:' ->  '$foo_'.
	 }
	asDictionary keysAndValuesDo: [ : inputSelector : pjSelectorPostfix | 
	self
		assert: [ PjCore makePharoJsSelector: inputSelector ]
		evaluatesTo: prefix , pjSelectorPostfix.
	].

	#('44_' 'foo' 'foo_') do: [ : selectorPostfix  | 
	self
		assert: [ PjCore makePharoJsSelector: prefix, selectorPostfix ]
		evaluatesTo: prefix , selectorPostfix.
	].

]

{ #category : 'tests' }
PjInfrastructureTest >> testSelectorRoundtripConversion [

	| prefix |
	prefix := self bridge exporter transpiler pharoJsSelectorPrefix.
	#( foo foo: _foo foo_ _foo: foo_: __foo: foo__: _foo_:_bar_: ) do: [
		:selector |
		self
			assert: [
				PjCore resetSelectorCache.
				PjCore makeSmalltalkSelector:
					(PjCore makePharoJsSelector: selector) ]
			evaluatesTo: selector ]
]

{ #category : 'tests' }
PjInfrastructureTest >> testSelectorStToPharoJsConversion [

	| pjPrefix |
	{
		(#foo -> 'foo').
		(#foo: -> 'foo:').
		(#, -> ',') } asDictionary keysAndValuesDo: [
		:providedSelector
		:exepectResult |
		self
			assert: [ PjCore makeSmalltalkSelector: providedSelector ]
			evaluatesTo: exepectResult ].
	pjPrefix := self evalBlock: [ PjCore pharoJsSelectorPrefix ].
	{
		('44_' -> ',').
		(#foo -> 'foo').
		(#foo_ -> 'foo:').
		('foo_$' -> 'foo_').
		('foo_$_bar_' -> 'foo_:bar:').
		('_$foo' -> '_foo') } asDictionary keysAndValuesDo: [
		:providedSelector
		:exepectResult |
		self
			assert: [
			PjCore makeSmalltalkSelector: (pjPrefix , providedSelector) ]
			evaluatesTo: exepectResult ]
]

{ #category : 'tests' }
PjInfrastructureTest >> testSetterGetsTrampolined [

	self bridge evalBlock: [ document js_at: 'foo' put: 17 ].
	self bridge evalBlock: [ document foo: 42 ].
	self assert: (self bridge evalBlock: [ document foo = 42 ])
]

{ #category : 'tests' }
PjInfrastructureTest >> testValueNonInterference [

	self addToDOM: '<input id="theInput" type="text" value="Name:">'.
	self assert: [|t| t := document getElementById: #theInput.t value=t defaultValue] evaluatesTo: true.
	self assert: [|t| t := document getElementById: #theInput.t value: 'addr'] evaluatesTo: 'addr'.
	self assert: [|t| t := document getElementById: #theInput.t value] evaluatesTo: 'addr'
]
