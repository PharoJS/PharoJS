Class {
	#name : #PjServerAppTestCase,
	#superclass : #PjAppTestCase,
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #'suite parameters' }
PjServerAppTestCase class >> isAbstract [
	^self == PjServerAppTestCase or: [ ^super isAbstract ].
]

{ #category : #'suite parameters' }
PjServerAppTestCase class >> targetPlatforms [
	^ { PjNodeJS }
]
