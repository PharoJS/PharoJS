Class {
	#name : #PjToolsTest2,
	#superclass : #PjToolsTest1,
	#category : #'PharoJs-Tools-Tests'
}

{ #category : #accessing }
PjToolsTest2 class >> c1 [
	^ 12
]

{ #category : #testing }
PjToolsTest2 class >> isAbstract [

	^ self = PjToolsTest2
]

{ #category : #'as yet unclassified' }
PjToolsTest2 >> m1 [
	^ 4
]
