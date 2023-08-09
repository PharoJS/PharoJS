Class {
	#name : #PjJavascriptCircularCounterTest,
	#superclass : #PjJavascriptCounterBrowserAppTest,
	#category : #'PharoJs-Examples-Tests-Counter'
}

{ #category : #tests }
PjJavascriptCircularCounterTest >> testDefaultCircularCounterDifferentForDefaultCounter [
	"Ceration order is important!"

	| defaultCounter defaultCircularCounter |
	defaultCounter := self evalBlock: [ PjCounter defaultInstance ].
	self deny: defaultCounter isNil.
	defaultCircularCounter := self evalBlock: [
		                          PjCircularCounter defaultInstance ].
	self deny: defaultCircularCounter isNil.
	self deny: defaultCircularCounter identicalTo: defaultCounter.
	self assert: defaultCounter jsClassName equals: PjCounter name.
	self
		assert: defaultCircularCounter jsClassName
		equals: PjCircularCounter name.
	3 timesRepeat: [ defaultCounter increment ].
	self assert: defaultCounter count equals: 3.
	self assert: defaultCircularCounter count equals: 0
]
