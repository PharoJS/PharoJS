Class {
	#name : #PjToolsTest1,
	#superclass : #PjWebApplication,
	#category : #'PharoJs-Tools-Tests'
}

{ #category : #accessing }
PjToolsTest1 class >> bridgeClientClass [
	^ nil
]

{ #category : #accessing }
PjToolsTest1 class >> c1 [
	^ self subclassResponsibility
]

{ #category : #testing }
PjToolsTest1 class >> isAbstract [

	^ self = PjToolsTest1
]

{ #category : #'as yet unclassified' }
PjToolsTest1 >> m1 [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PjToolsTest1 >> m2 [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PjToolsTest1 >> m3 [
	^ 18
]
