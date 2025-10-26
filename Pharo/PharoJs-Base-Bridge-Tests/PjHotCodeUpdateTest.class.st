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
PjHotCodeUpdateTest >> testLeafClassMethodAdded [
	| changedClass jsClass |
	changedClass := factory newClass. 
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name.
	self should: [ jsClass m1 ] raise: Error.
	changedClass class compile: 'm1
	^42'.
	self assert: jsClass m1 equals: 42.
	
	
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
	^12345'.
	self assert: jsClass m1 equals: 12345.
	
	
]

{ #category : 'tests' }
PjHotCodeUpdateTest >> testLeafInstanceMethodAdded [
	| changedClass jsClass jsInstance |
	changedClass := factory newClass.
	self bridge loadClass: changedClass.
	jsClass := self bridge jsGlobalAt: changedClass name.
	jsInstance := jsClass new.
	changedClass compile: 'm1
	^42'.
	self assert: jsInstance m1 equals: 42.
	
	
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
	
	
]
