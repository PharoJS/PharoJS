Class {
	#name : #PjClassExtensionTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #tests }
PjClassExtensionTest >> setUp [

	super setUp.
	self bridge loadAllClasses: { 
			PjASuperClass.
			PjBSubClassOfA }.
	self bridge loadClass: PjExtensionOfBSubClassOfA.

]

{ #category : #tests }
PjClassExtensionTest >> testClassMessageToSuper [

	self
		assert: [ PjBSubClassOfA someString ]
		evaluatesTo: 'Ultimate Answer'
]

{ #category : #tests }
PjClassExtensionTest >> testClassMethodAlias [

	self
		assert: [ PjBSubClassOfA someString ]
		evaluatesTo: 'Ultimate Answer'
]

{ #category : #tests }
PjClassExtensionTest >> testEmptyClassExtension [

	self bridge loadClass: PjEmptyClassExtensionOfASuperClass.
	self assertEquivalent: [ PjASuperClass someString ].
	self assertEquivalent: [ PjASuperClass new someNumber ]
]

{ #category : #tests }
PjClassExtensionTest >> testInstanceMessageToSuper [

	self assert: [ PjBSubClassOfA new someNumber ] evaluatesTo: 42
]

{ #category : #tests }
PjClassExtensionTest >> testInstanceMethodAlias [

	self assert: [ PjBSubClassOfA new someNumberAlias ] evaluatesTo: 42
]
