Class {
	#name : #PjProxyTest,
	#superclass : #PjBridgeTestCase,
	#pools : [
		'PjDomGlobals',
		'PjUniversalGlobals'
	],
	#category : #'PharoJsBridgeTest-Tests'
}

{ #category : #testing }
PjProxyTest >> testArrayEquality [
	self assertBlock: [ #() ] equalsBlock: [ #() ].
	self denyBlock: [ #() ] equalsBlock: [ #(1 2 3) ].
	self assertBlock: [ #(1 2 3) ] equalsBlock: [ #(1 2 3) ].
	self denyBlock: [ #(1 2) ] equalsBlock: [ #(1 2 3) ].
	self denyBlock: [ #(1 3 2) ] equalsBlock: [ #(1 2 3) ].
	self assertBlock: [ #(one two three) ] equalsBlock: [ #(one two three) ].
	self assertBlock: [ {true. 'two'. nil. 3.14.}] equalsBlock: [ {true. 'two'. nil. 3.14.} ].
	self assertBlock: [ {{true. 'two'}. nil. 3.14.}] equalsBlock: [ {{true. 'two'}. nil. 3.14.} ].
	self denyBlock: [ {{true. 'two'}. nil. 3.14.}] equalsBlock: [ {{false. 'abc'}. nil. 3.14.} ].

]

{ #category : #testing }
PjProxyTest >> testAsJson [
	self assert: 42 asJSON equals: '42'.
	self assert: 'a\b"c' asJSON equals: '"a\\b\"c"'.
	self assert: nil asJSON equals: 'undefined'.

]

{ #category : #testing }
PjProxyTest >> testBlockClosures [
	document body addEventListener: 'click' block: [ 42 ].
	self
		should: [ document body addEventListener: 'click' block: 42 ]
		raise: Error.
	self
		should: [ document body addEventListener: 'click' block: [ :ev | ^ 42 ] ]
		raise: Error.
	self
		assert: (document body addEventListener: 'click' block: [ :ev | 17 ])
		equals: true.
	self assert: self bridge blockClosures size equals: 1.
	self
		assert: (document body addEventListener: 'click' block: [ :ev | 42 ])
		equals: true.
	self assert: self bridge blockClosures size equals: 1.
	document body removeEventListener: 'click'.
	self assert:
		self bridge blockClosures size equals: 0
]

{ #category : #testing }
PjProxyTest >> testBrowser [
	self assert: (window hasOwnProperty: 'document') description: 'window properies'
]

{ #category : #testing }
PjProxyTest >> testChildren [
	| rectangle other |
	rectangle := document createElement: 'span'.
	rectangle id: 'grn'.
	document body
		appendChild: rectangle.
	self assert: (document getElementById: 'grn') children size equals: 0.
	other := document createElement: 'span'.
	other id: 'other'.
	rectangle appendChild: other.
	Smalltalk garbageCollect.
	self assert: (document getElementById: 'grn') children size equals: 1.
	self assert: (document getElementsByTagName: 'span') size equals: 2.
	self assert: ((document getElementsByTagName: 'span') at: 1) id equals: 'grn'
]

{ #category : #testing }
PjProxyTest >> testClick [
	| rectangle count |
	count := 0.
	rectangle := document createElement: 'div'.
	rectangle id: 'grn'.
	rectangle instVarNamed: #count put: 0.	" need to use instVarNamed:put: to force creation of slot "
	Smalltalk garbageCollect.
	document body appendChild: rectangle.
	rectangle
		addEventListener: 'click'
		block: [ :xev | 
			count := count + 1.
			rectangle count: rectangle count + 1 ].
	self bridge
		evalJavascript:
			'(' , rectangle asJSON , '.click(false),' , rectangle asJSON
				, '.click(true),false)'.
	Smalltalk garbageCollect.
	rectangle dispatchEvent: (window MouseEvent new: #click).
	rectangle dispatchEvent: (window MouseEvent new: #click).
	self assert: (document getElementById: 'grn') count equals: 4.
	Smalltalk garbageCollect.
	self assert: (document getElementById: 'grn') count equals: 4.
	rectangle dispatchEvent: (window MouseEvent new: #click).
	rectangle dispatchEvent: (window MouseEvent new: #click).
	Smalltalk garbageCollect.
	self assert: (document getElementById: 'grn') count equals: 6.
	self assert: count = 6
]

{ #category : #testing }
PjProxyTest >> testClickWithEventTarget [
	| rectangle1 rectangle2 lastClickedRectangle count listenerBlock |
	count := 0.
	rectangle1 := document createElement: 'div'.
	rectangle1 id: 'rect1'.
	rectangle1 instVarNamed: #count put: 0.
	rectangle2 := document createElement: 'div'.
	rectangle2 id: 'rect2'.
	rectangle2 instVarNamed: #count put: 0.
	Smalltalk garbageCollect.
	document body appendChild: rectangle1.
	document body appendChild: rectangle2.
	listenerBlock := [ :xev :this | 
	| alsoRectangle |
	alsoRectangle := this.
	lastClickedRectangle := alsoRectangle.
	count := count + 1.
	alsoRectangle count: alsoRectangle count + 1 ].
	rectangle1 addEventListener: 'click' block: listenerBlock.
	rectangle2 addEventListener: 'click' block: listenerBlock.
	rectangle1 dispatchEvent: (window MouseEvent new: #click).
	self assert: (document getElementById: 'rect1') count equals: 1.
	self assert: rectangle1 equals: lastClickedRectangle.
	self assert: (document getElementById: 'rect2') count equals: 0.
	self assert: count = 1.
	rectangle2 dispatchEvent: (window MouseEvent new: #click).
	Smalltalk garbageCollect.
	self assert: rectangle2 equals: lastClickedRectangle.
	self assert: (document getElementById: 'rect1') count equals: 1.
	self assert: (document getElementById: 'rect2') count equals: 1.
	self assert: count = 2
]

{ #category : #testing }
PjProxyTest >> testGetElementById [
	| rectangle |
	rectangle := document createElement: 'div'.
	rectangle id: 'grn'.
	document body
		appendChild: rectangle.
	self assert: (document getElementById: 'grn') id equals: 'grn'.
	self assert: (document js_getElementById: 'grn') id equals: 'grn'
]

{ #category : #testing }
PjProxyTest >> testIterateOverChildren [
	| container newChild |
	container := document createElement: 'div'.
	10 timesRepeat: [
		newChild := document createElement: 'span'.
		container appendChild: newChild].
	self assert: container children size equals: 10.
	container children withIndexDo: [ : each : index | 
		each textContent: index].

]

{ #category : #testing }
PjProxyTest >> testValueNonInterference [
	| theInput |
	self
		addToDOM: '<input id="testValueNonInterference" type="text" value="Name:">'.
	theInput := self bridge
		evalBlock: [ document getElementById: #testValueNonInterference ].
	self assert: theInput value equals: theInput defaultValue
]
