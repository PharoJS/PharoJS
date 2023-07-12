Class {
	#name : #PjWebAppTestCase,
	#superclass : #PjAppTestCase,
	#traits : 'PjTWebAppTestCase',
	#classTraits : 'PjTWebAppTestCase classTrait',
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #accessing }
PjWebAppTestCase >> document [ 	
	^document
]
