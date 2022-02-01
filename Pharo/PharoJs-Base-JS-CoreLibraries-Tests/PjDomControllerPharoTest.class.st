Class {
	#name : #PjDomControllerPharoTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInPharo',
	#classTraits : 'PjTAppRunsInPharo classTrait',
	#instVars : [
		'domElement'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Controllers'
}

{ #category : #'suite parameters' }
PjDomControllerPharoTest class >> appClass [
	^PjMinimalApp
]

{ #category : #testing }
PjDomControllerPharoTest >> appClassToExport [
	^PjAppWrapperForRunningInPharo on: self appClass
]

{ #category : #testing }
PjDomControllerPharoTest >> currentApp [
	^self appClass
		start; 
		currentInstance.
]

{ #category : #testing }
PjDomControllerPharoTest >> setUp [
	super setUp.
	domElement := app createElement: 'div'
]

{ #category : #testing }
PjDomControllerPharoTest >> testCssClassARemoval [
	app cssClassesStringElement: domElement set: 'a b c'.
	self assert: (app cssClassesStringElement: domElement) equals: 'a b c'.
	app cssClassesRemoveAll: #(a c) element: domElement.
	self assert: (app cssClassesStringElement: domElement) trimBoth equals: 'b'
]

{ #category : #testing }
PjDomControllerPharoTest >> testCssClassAddition [
	self assert: (app cssClassesStringElement: domElement) equals: ''.
	app cssClassesAddAll: #(a b c) element: domElement.
	self assert: (app cssClassesStringElement: domElement) trimBoth equals: 'a b c'
]

{ #category : #testing }
PjDomControllerPharoTest >> testCssClassReplacement [
	app cssClassesStringElement: domElement set: 'a b c'.
	self assert: (app cssClassesStringElement: domElement) equals: 'a b c'.
	app cssClassesReplaceAll: #(a c) byAll: #(x y) element: domElement.
	self assert: (app cssClassesStringElement: domElement) trimBoth equals: 'b x y'
]
