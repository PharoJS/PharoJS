Class {
	#name : #PjPerformTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #tests }
PjPerformTest >> testPerform [

	self assertEquivalent: [ 3 perform: #negated ]
]

{ #category : #tests }
PjPerformTest >> testPerformWith [

	self assertEquivalent: [3 perform: #* with: 14]
]

{ #category : #tests }
PjPerformTest >> testPerformWithArguments [

	self assertEquivalent: [3 perform: #* withArguments: #(14)]
]
