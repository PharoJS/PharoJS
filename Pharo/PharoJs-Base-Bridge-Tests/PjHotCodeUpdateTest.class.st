Class {
	#name : 'PjHotCodeUpdateTest',
	#superclass : 'PjBridgeTestCase',
	#instVars : [
		'factory'
	],
	#category : 'PharoJs-Base-Bridge-Tests-Base',
	#package : 'PharoJs-Base-Bridge-Tests',
	#tag : 'Base'
}

{ #category : 'tests' }
PjHotCodeUpdateTest >> hotCodeUpdater [

	^ self bridge hotCodeUpdater
]

{ #category : 'running' }
PjHotCodeUpdateTest >> setUp [ 
	super setUp.
	factory := ClassFactoryForTestCase new.
]

{ #category : 'running' }
PjHotCodeUpdateTest >> tearDown [ 
	factory cleanUp.
	PjHotCodeUpdater allInstancesDo: #unsubscribe.
	super tearDown.

]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testClassMethodAddedToNonLoadedClass [

	| changedClass |
	changedClass := factory newClass.
	changedClass class compile: 'm1
	^42'.
	self should: [self bridge jsGlobalAt: changedClass name] raise: Error
]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testInstanceMethodAddedToNonLoadedClass [

	| changedClass |
	changedClass := factory newClass.
	changedClass compile: 'm1
	^42'.
	self should: [self bridge jsGlobalAt: changedClass name] raise: Error
]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testLeafClassIvAccessMethodAdded [
	| changedClass jsClass jsInstance |
	changedClass := factory make: [: builder | builder slots: #(x y) ].
	changedClass compile: 'x: newX y: newY
		x := newX.
		y := newY';
		compile: 'sumXY
			^x + y'.
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name.
	jsInstance := jsClass new.
	jsInstance x: 20 y: 22.
	self assert: jsInstance sumXY equals: 42.
	
	
]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testLeafClassIvAdditions [
	| changedClass jsClass | 
	changedClass := factory newClass.
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name. 
	changedClass := factory update: changedClass to: [: builder | 
		builder classSlots: #(x y) ]. 
	changedClass class compile: 'x: newX y: newY
		x := newX.
		y := newY'.
	changedClass class compile: 'sumXY
			^x + y'.
	jsClass x: 20 y: 22.
	self assert: jsClass sumXY equals: 42.
	
	
]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testLeafClassMethodAdditions [
	| changedClass jsClass |
	changedClass := factory newClass. 
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name.
	self should: [ jsClass m1 ] raise: Error. 
	changedClass class compile: 'm1
	^42'. 
	self assert: jsClass m1 equals: 42.
	changedClass class compile: 'm2
	^12345'.
	self assert: jsClass m2 equals: 12345.

]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testLeafClassMethodChanged [
	| changedClass jsClass |
	changedClass := factory newClass.
	changedClass class compile: 'm1
	^42'.
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name.
	changedClass class compile: 'm1
	^37'.
	self assert: jsClass m1 equals: 37.
	changedClass class compile: 'm1
	^12345'.
	self assert: jsClass m1 equals: 12345.	
]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testLeafClassMethodRemoval [
	| changedClass jsClass |
	changedClass := factory newClass. 
	changedClass class compile: 'm1
	^42'. 
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name.
	changedClass class removeSelector: #m1. 
	self should: [ jsClass m1 ] raise: Error. 

]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testLeafInstanceIvAdditions [
	| changedClass jsClass jsInstance | 
	changedClass := factory newClass.
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name. 
	changedClass := factory update: changedClass to: [: builder | 
		builder slots: #(x y) ]. 
	changedClass compile: 'x: newX y: newY
		x := newX.
		y := newY'.
	changedClass compile: 'sumXY
			^x + y'.
	jsInstance := jsClass new.
	jsInstance x: 20 y: 22.
	self assert: jsInstance sumXY equals: 42.
	
	
]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testLeafInstanceMethodAdditions [
	| changedClass jsClass jsInstance |
	changedClass := factory newClass.
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name.
	jsInstance := jsClass new.
	changedClass compile: 'm1
	^42'.
	self assert: jsInstance m1 equals: 42.
	changedClass compile: 'm2
	^12345'.
	self assert: jsInstance m2 equals: 12345.

]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testLeafInstanceMethodChanged [
	| changedClass jsClass jsInstance |
	changedClass := factory newClass.
	changedClass compile: 'm1
	^42'.
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name.
	jsInstance := jsClass new.
	changedClass compile: 'm1
	^37'.
	self assert: jsInstance m1 equals: 37.
	changedClass compile: 'm1
	^12345'.
	self assert: jsInstance m1 equals: 12345.
]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testLeafInstanceMethodRemoval [
	| changedClass jsClass jsInstance |
	changedClass := factory newClass. 
	changedClass compile: 'm1
	^42'. 
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name.
	jsInstance := jsClass new.
	changedClass removeSelector: #m1. 
	self should: [ jsInstance m1 ] raise: Error. 

]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testSuperclassMethodAdditions [
	| changedClass jsSubclass subclass |
	changedClass := factory newClass. 
	subclass := factory make: [ : builder | builder superclass: changedClass ].
	self bridge loadClass: subclass.
	jsSubclass := self bridge jsGlobalAt: subclass name.
	self should: [ jsSubclass m1 ] raise: Error. 
	changedClass class compile: 'm1
	^42'. 
	self assert: jsSubclass m1 equals: 42.
	changedClass class compile: 'm2
	^12345'.
	self assert: jsSubclass m2 equals: 12345.

]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testUpdaterDoesNothingIfBridgeIsNil [

	| changedClass |
	changedClass := factory newClass.
	self bridge loadClass: changedClass.
	self hotCodeUpdater bridge: nil.
	changedClass compile: 'm1
	^42'.
	self
		shouldnt: [
			self hotCodeUpdater
				updateMethod: changedClass >> #m1
				in: changedClass ]
		raise: Error
]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testUpdaterDoesNothingIfBridgeIsNotConnected [
	| changedClass |
	changedClass := factory newClass.
	self bridge loadClass: changedClass.
	self bridge stop.
	changedClass compile: 'm1
	^42'.
	self
		shouldnt: [
			self hotCodeUpdater
				updateMethod: changedClass >> #m1
				in: changedClass ]
		raise: Error
]
