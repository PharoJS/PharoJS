Class {
	#name : #PjRectableTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Objects'
}

{ #category : #tests }
PjRectableTest >> testRectangle [

	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) center x ].
		self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) center y ]
]
