Class {
	#name : #PjJavascriptCircularCounterTest,
	#superclass : #PjJavascriptCounterBrowserAppTest,
	#category : #'PharoJs-Examples-Tests-Counter'
}

{ #category : #tests }
PjJavascriptCircularCounterTest >> testDefaultCircularCounterDifferentForDefaultCounter [
	"Ceration order is important!"

	| defaultCounter defaultCircularCounter defaulCircularCounter |
	defaultCounter := self evalBlock: [ PjCounter defaultInstance ].
	defaultCircularCounter := self evalBlock: [
		                          PjCircularCounter defaultInstance ].
	self deny: defaulCircularCounter == defaultCounter.
	self assert:    [defaultCounter className] evaluatesTo: PjCounter name.
	self
		assert: [defaulCircularCounter className]
		evaluatesTo: PjCircularCounter name.
	3 timesRepeat: [ defaultCounter increment ].
	self assert: defaultCounter count equals: 3.
	self assert: defaulCircularCounter count equals: 0
]
