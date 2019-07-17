Class {
	#name : #LjAutomaticEventGenerationTest,
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'subject'
	],
	#category : #'LightweightObserverJS-Tests'
}

{ #category : #testing }
LjAutomaticEventGenerationTest >> setUp [
	super setUp.
	self bridge loadAllClasses: {LoEventDispatcher. LoGenericObserver. LoSubject. LoSubjectForTest. LoSubjectArray. LoSubjectDictionary . LoSubjectOrderedCollection . LoSubjectSortedCollection }, LoSingleElementChangeEvent withAllSubclasses.
	subject := self evalBlock: [LoSubjectForTest new].
]

{ #category : #testing }
LjAutomaticEventGenerationTest >> testObservingAnyIvChange [
	window instVarNamed: #changeCounter put: 0.
	self evalBlock: [subject afterChangeDo: [window changeCounter: window changeCounter + 1 ]].
	subject a: #someValue.
	self assert: window changeCounter equals: 1.
	subject b: #otherValue.
	self assert: window changeCounter equals: 2.
]

{ #category : #testing }
LjAutomaticEventGenerationTest >> testObservingMultipleIvsNewValues [
	self evalBlock: [subject afterChangeDo: [: event | 
		window instVarNamed: #aLastValue put: (event newValueFor: #a).
		window instVarNamed: #bLastValue put: (event newValueFor: #b) ]].
	subject a: #someValue b: #otherValue.
	self assert: window aLastValue equals: #someValue.
	self assert: window bLastValue equals: #otherValue.

]

{ #category : #testing }
LjAutomaticEventGenerationTest >> testObservingSpecificIvChange [
	window instVarNamed: #changeCounterA put: 0.
	window instVarNamed: #changeCounterB put: 0.
	self evalBlock: [
		subject afterChangeOf: #a do: [window changeCounterA: window changeCounterA + 1 ].
		subject afterChangeOf: #b do: [window changeCounterB: window changeCounterB + 1 ]].
	subject a: #someValue.
	self assert: window changeCounterA equals: 1.
	self assert: window changeCounterB equals: 0.
	subject b: #otherValue.
	self assert: window changeCounterA equals: 1.
	self assert: window changeCounterB equals: 1.

]

{ #category : #testing }
LjAutomaticEventGenerationTest >> testObservingSpecificIvNewValue [
	self evalBlock: [
		subject afterChangeOf: #a do: [: newValue | window instVarNamed: #newA put: newValue ].
		subject afterChangeOf: #b do: [: newValue | window instVarNamed: #newB put: newValue ]].
	subject a: #someValue.
	subject a: #someValue.
	self assert: window newA equals: #someValue.
	subject b: #otherValue.
	self assert: window newB equals: #otherValue.

]

{ #category : #testing }
LjAutomaticEventGenerationTest >> testRestartObservingAnyIvChange [
	| observer |
	window instVarNamed: #changeCounter put: 0.
	observer := self evalBlock: [subject afterChangeDo: [window changeCounter: window changeCounter + 1 ]].
	observer stopObserving.
	subject a: #someValue.
	observer startObserving.
	self assert: window changeCounter equals: 0.
	subject b: #otherValue.
	self assert: window changeCounter equals: 1.
]

{ #category : #testing }
LjAutomaticEventGenerationTest >> testStopObservingAnyIvChange [
	| observer |
	window instVarNamed: #changeCounter put: 0.
	observer := self evalBlock: [subject afterChangeDo: [window changeCounter: window changeCounter + 1 ]].
	subject a: #someValue.
	self assert: window changeCounter equals: 1.
	observer stopObserving.
	subject b: #otherValue.
	self assert: window changeCounter equals: 1.
]

{ #category : #testing }
LjAutomaticEventGenerationTest >> testStopObservingSpecificIvChange [
	| aObserver |
	window instVarNamed: #changeCounterA put: 0.
	window instVarNamed: #changeCounterB put: 0.
	aObserver := self evalBlock: [
		subject afterChangeOf: #a do: [window changeCounterA: window changeCounterA + 1 ]].
	self evalBlock: [
		subject afterChangeOf: #b do: [window changeCounterB: window changeCounterB + 1 ]].
	aObserver stopObserving.
	subject a: #someValue.
	self assert: window changeCounterA equals: 0.
	self assert: window changeCounterB equals: 0.
	subject b: #otherValue.
	self assert: window changeCounterA equals: 0.
	self assert: window changeCounterB equals: 1.

]
