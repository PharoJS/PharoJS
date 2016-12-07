Class {
	#name : #PjCompositeTestSuite,
	#superclass : #TestSuite,
	#instVars : [
		'subSuites'
	],
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #'initialize-release' }
PjCompositeTestSuite >> addSubSuite: aSuite [
	self subSuites add: aSuite.
]

{ #category : #accessing }
PjCompositeTestSuite >> addTest: aTest [
	self subSuites do: [: aSuite | aSuite addTest: aTest].
]

{ #category : #running }
PjCompositeTestSuite >> debug [
	self subSuites do: [ : aSuite |  aSuite debug].
]

{ #category : #'initialize-release' }
PjCompositeTestSuite >> initialize [
	super initialize.
	subSuites := Set new.
]

{ #category : #running }
PjCompositeTestSuite >> run: aTestResult [
	self subSuites ifEmpty: [ 
		^self error: 'Please choose target platforms among subclasses of ', PjPlatform name].
	self subSuites do: [ : each | each run: aTestResult ]
]

{ #category : #accessing }
PjCompositeTestSuite >> subSuites [
	^subSuites
]

{ #category : #announcements }
PjCompositeTestSuite >> subscribe: aAnnouncement do: aBlock [
	self subSuites do: [ : each | each subscribe: aAnnouncement do: aBlock].

]
