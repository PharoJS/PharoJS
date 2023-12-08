Class {
	#name : #PjInstanceInitTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Initialization'
}

{ #category : #tests }
PjInstanceInitTest >> jsNew: aClass [

^self bridge evalJavascript: 'new ',  aClass name.

]

{ #category : #tests }
PjInstanceInitTest >> testInitializeSkippedWithBasicNew [

	| jsObject |
	self assert: [ PjClassForInitTest basicNew x ] evaluatesTo: nil.
	jsObject := self evalBlock: [ PjSubclassForInitTest basicNew ].
	self assert: jsObject x equals: nil.
	self assert: jsObject y equals: nil
]

{ #category : #tests }
PjInstanceInitTest >> testInitializeWithJsNewOperator [

	| jsObject |
	self bridge loadClass:
			PjClassForInitTest.
	jsObject := self jsNew: PjClassForInitTest.
	self assert: jsObject x equals: 42.

]

{ #category : #tests }
PjInstanceInitTest >> testInitializeWithJsNewOperatorOnSubclass [

	| jsObject |
	self bridge loadClass: PjSubclassForInitTest.
	jsObject := self jsNew: PjSubclassForInitTest.
	self assert: jsObject x equals: 42.
	self assert: jsObject y equals: 'PharoJS'
]

{ #category : #tests }
PjInstanceInitTest >> testInitializeWithNewMessage [

	| jsObject |
	self assert: [ PjClassForInitTest new x ] evaluatesTo: 42.
	jsObject := self evalBlock: [ PjSubclassForInitTest new ].
	self assert: jsObject x equals: 42.
	self assert: jsObject y equals: 'PharoJS'
]
