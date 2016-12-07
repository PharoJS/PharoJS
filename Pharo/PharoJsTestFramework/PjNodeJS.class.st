Class {
	#name : #PjNodeJS,
	#superclass : #PjPlatform,
	#classInstVars : [
		'pathForNode'
	],
	#category : #'PharoJsTestFramework-Platforms'
}

{ #category : #'as yet unclassified' }
PjNodeJS class >> pathForNode [
	^ pathForNode ifNil: [
		pathForNode := UIManager default chooseFileName: 'Please select the executable for NodeJS'
	]
]

{ #category : #running }
PjNodeJS >> commandStringWith: aFileReference [ 
	^ PjNodeJS pathForNode, (self pathString: aFileReference/'index.js')
]
