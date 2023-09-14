Class {
	#name : #PjRectangleTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Objects'
}

{ #category : #tests }
PjRectangleTest >> testCorners [

	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) topLeft x ].
	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) topRight x ].
	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) bottomLeft x ].
	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) bottomRight x ].
	
	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) topLeft y ].
	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) topRight y ].
	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) bottomLeft y ].
	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) bottomRight y ].
]

{ #category : #tests }
PjRectangleTest >> testRectangleOriginConer [

	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) center x ].
	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) center y ]
]

{ #category : #tests }
PjRectangleTest >> testRectangleWidthHeight [

	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) width ].
	self assertEquivalent: [
		(Rectangle origin: 0 @ 10 corner: 20 @ 20) height ]
]

{ #category : #tests }
PjRectangleTest >> testtranslateBy [

	self assertEquivalent: [
		((Rectangle origin: 0 @ 10 corner: 20 @ 20) translateBy: 17 @ 17)
			topLeft x ].
	self assertEquivalent: [
		((Rectangle origin: 0 @ 10 corner: 20 @ 20) translateBy: 25 @ 17)
			topLeft y ]
]
