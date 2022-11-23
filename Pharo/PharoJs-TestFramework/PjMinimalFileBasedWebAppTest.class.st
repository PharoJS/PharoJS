Class {
	#name : #PjMinimalFileBasedWebAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-TestFramework-Test'
}

{ #category : #'suite parameters' }
PjMinimalFileBasedWebAppTest class >> appClass [
	^PjMinimalFileBasedWebApp.
]

{ #category : #tests }
PjMinimalFileBasedWebAppTest >> testAppReady [
	self assert: [1+2] evaluatesTo: 3
]

{ #category : #tests }
PjMinimalFileBasedWebAppTest >> testCounter [
	| jsCounter |
	jsCounter := self evalBlock: [PjCounter new].
	3 timesRepeat: [jsCounter increment].
	self assert: jsCounter count equals: 3
]

{ #category : #tests }
PjMinimalFileBasedWebAppTest >> testCounterWithEvent [
	| counter button |
	counter := PjCounter new.
	button := document createElement: 'button'.
	button textContent: 'increment'.
	button addEventListener: #click block: [ counter increment ].
	3 timesRepeat: [button click].
	self assert: counter count equals: 3
]

{ #category : #tests }
PjMinimalFileBasedWebAppTest >> testCounterWithSerialization [
	| counter serializedCounter jsCounter |
	counter := PjCounter new.
	3 timesRepeat: [counter increment].
	serializedCounter := counter asPhxJsonString.
	self bridge loadClass: PjCounter.
	jsCounter := self evalBlock: [PhxJsonReader readFromString: serializedCounter].
	3 timesRepeat: [jsCounter increment].
	self assert: counter count equals: 3.
	self assert: jsCounter count equals: 6
]

{ #category : #tests }
PjMinimalFileBasedWebAppTest >> testResetApp [
	self evalBlock: [window instVarNamed:#forTest put: 3].
	self assert: [window instVarNamed:#forTest] evaluatesTo: 3.
	self resetApp.
	self assert: [window instVarNamed:#forTest] evaluatesTo: nil.
]
