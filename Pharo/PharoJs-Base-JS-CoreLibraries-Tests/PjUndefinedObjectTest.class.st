Class {
	#name : #PjUndefinedObjectTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Objects'
}

{ #category : #tests }
PjUndefinedObjectTest >> testNilCannotBeReplaced [

	self evalBlock: [
		window at: #originalNil put: PjUndefinedObject uniqueInstance ].
	self
		should: [
		self evalBlock: [ PjUndefinedObject uniqueInstance: #( 42 ) ] ]
		raise: Error.
	self assertBlock: [
		(window at: #originalNil) == PjUndefinedObject uniqueInstance ]
]

{ #category : #tests }
PjUndefinedObjectTest >> testNilObjectDoesNotLeak [
	self assertBlock: [
		nil value == nil ].
	self assertBlock: [ nil yourself == nil ]
]

{ #category : #tests }
PjUndefinedObjectTest >> testNilStructureCannotChange [

	self should: [self evalBlock: [ nil at: #newProperty put: 42 ]] raise: Error.
	self assert: [ nil at: #newProperty ] evaluatesTo: nil.

]
