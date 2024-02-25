Trait {
	#name : #PjTWebAppTestCase,
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #asserting }
PjTWebAppTestCase >> assertHidden: element [

	self waitUntil: [(self computedDisplayStyleOf: element) = 'none']
]

{ #category : #asserting }
PjTWebAppTestCase >> assertInnerHtmlOfElement: domElement equals: expectedValue [
	self assert: domElement innerHTML equals: expectedValue
]

{ #category : #asserting }
PjTWebAppTestCase >> assertInnerHtmlOfElementById: id equals: expectedValue [

	self
		assertInnerHtmlOfElement: (self document getElementById: id)
		equals: expectedValue
]

{ #category : #asserting }
PjTWebAppTestCase >> assertShowing: element [

	self waitWhile: [ (self computedDisplayStyleOf: element) = 'none' ]
]

{ #category : #asserting }
PjTWebAppTestCase >> assertValueOfElement: domElement equals: expectedValue [
	self assert: domElement value equals: expectedValue
]

{ #category : #asserting }
PjTWebAppTestCase >> assertValueOfElementById: id equals: expectedValue [

	self
		assertValueOfElement: (self document getElementById: id)
		equals: expectedValue
]

{ #category : #'UI handling' }
PjTWebAppTestCase >> changeElement: domElement value: newValue [
	domElement value: newValue.
	self dispatchEvent: #change to: domElement.
]

{ #category : #'UI handling' }
PjTWebAppTestCase >> changeElementById: anId value: newValue [

	self changeElement: (self document getElementById: anId) value: newValue
]

{ #category : #'UI handling' }
PjTWebAppTestCase >> clickElement: domElement [ 
	self dispatchEvent: #click to: domElement.
]

{ #category : #'UI handling' }
PjTWebAppTestCase >> clickElementById: aString [

	self clickElement: (self document getElementById: aString)
]

{ #category : #'UI handling' }
PjTWebAppTestCase >> computedDisplayStyleOf: element [

	^ (self window getComputedStyle: element) display
]

{ #category : #'UI handling' }
PjTWebAppTestCase >> dispatchEvent: eventName to: htmlElement [
	htmlElement dispatchEvent: (self newEvent: eventName)
]

{ #category : #accessing }
PjTWebAppTestCase >> document [
	self explicitRequirement 
]

{ #category : #'UI handling' }
PjTWebAppTestCase >> newEvent: eventName [

	| event |
	event := self document createEvent: #HTMLEvents.
	event initEvent: eventName with: true with: true.
	^ event
]

{ #category : #accessing }
PjTWebAppTestCase >> window [

	self explicitRequirement
]
