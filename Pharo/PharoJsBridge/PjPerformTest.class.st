Class {
	#name : #PjPerformTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsBridge-Tests'
}

{ #category : #'as yet unclassified' }
PjPerformTest >> testPerform [
	self assertEquivalent: [3 perform: #negated].
]

{ #category : #'as yet unclassified' }
PjPerformTest >> testPerformWith [
	self assertEquivalent: [3 perform: #* with: 14]
]

{ #category : #'as yet unclassified' }
PjPerformTest >> testPerformWithArguments [
	self assertEquivalent: [3 perform: #* withArguments: #(14)]
]
