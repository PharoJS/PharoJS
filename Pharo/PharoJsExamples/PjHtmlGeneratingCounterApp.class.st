Class {
	#name : #PjHtmlGeneratingCounterApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'count',
		'countDisplay'
	],
	#category : #'PharoJsExamples-Counter'
}

{ #category : #'initialize-release' }
PjHtmlGeneratingCounterApp >> buttonsSharedCss [
	^ {
	#border -> 'none'.
	#padding -> '15px 32px'.
	#textAlign -> 'center'.
	#textDecoration -> 'none'.
	#display -> 'inline-block'.
	#fontSize -> '16px'}
]

{ #category : #'initialize-release' }
PjHtmlGeneratingCounterApp >> containerCss [
	^ {
	#width -> '100%'.
	#textAlign -> 'center'.
	#backgroundColor -> '#ddffdd'.
	#padding -> '50px'.
	#boxSizing -> 'border-box'}
]

{ #category : #accessing }
PjHtmlGeneratingCounterApp >> count [
	^ count
]

{ #category : #accessing }
PjHtmlGeneratingCounterApp >> count: newCount [
	count := newCount.
	countDisplay innerHTML: newCount
]

{ #category : #'initialize-release' }
PjHtmlGeneratingCounterApp >> initialize [
	| container incrementButton decrementButton |
	super initialize.
	container := self addElement: 'div' style: self containerCss.
	countDisplay := self addElement: 'div' to: container style: {#fontSize -> '300%'}.
	self addElement: 'br' to: container.
	incrementButton := self addElement: 'button' to: container style: self buttonsSharedCss.
	incrementButton innerHTML: 'Increment'.
	self setElement: incrementButton style: {#backgroundColor -> '#ccf5ff'}.
	self onClickElement: incrementButton do: [ self count: self count + 1 ].
	decrementButton := self addElement: 'button' to: container style: self buttonsSharedCss.
	decrementButton innerHTML: 'Decrement'.
	self onClickElement: decrementButton do: [ self count: self count - 1 ].
	self setElement: decrementButton style: {#backgroundColor -> '#ffe6e6'}.
	self count: 0
]
