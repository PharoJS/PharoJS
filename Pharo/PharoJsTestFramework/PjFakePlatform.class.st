Class {
	#name : #PjFakePlatform,
	#superclass : #PjPlatform,
	#category : #'PharoJsTestFramework-Test'
}

{ #category : #testing }
PjFakePlatform >> isAvailable [
	^true
]

{ #category : #running }
PjFakePlatform >> setUp [
	^self
]

{ #category : #running }
PjFakePlatform >> stopApp [
	^self
]

{ #category : #running }
PjFakePlatform >> tearDown [
	^self
]
