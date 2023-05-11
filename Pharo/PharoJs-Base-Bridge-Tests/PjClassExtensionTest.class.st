Class {
	#name : #PjClassExtensionTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #tests }
PjClassExtensionTest >> testClassMessageToSuper [

	self bridge loadAllClasses: { 
			PjASuperClass.
			PjBSubClassOfA }.
	self bridge loadClass: PjExtensionOfBSubClassOfA.
	self assert: [ PjBSubClassOfA someString ] evaluatesTo: 'Ultimate Answer'
]

{ #category : #tests }
PjClassExtensionTest >> testInstanceMessageToSuper [

	self bridge loadAllClasses: { 
			PjASuperClass.
			PjBSubClassOfA }.
	self bridge loadClass: PjExtensionOfBSubClassOfA.
	self assert: [ PjBSubClassOfA new someNumber ] evaluatesTo: 42
]
