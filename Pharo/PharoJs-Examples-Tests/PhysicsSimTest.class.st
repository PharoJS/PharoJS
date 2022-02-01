Class {
	#name : #PhysicsSimTest,
	#superclass : #PjWebAppTestCase,
	#category : #'PharoJs-Examples-Tests-PhysicsSimulation'
}

{ #category : #'suite parameters' }
PhysicsSimTest class >> appClass [
	^PhysicsSim
]

{ #category : #testing }
PhysicsSimTest >> testAppInitialSetup [
	self assert: app bodies size equals: 3
]

{ #category : #testing }
PhysicsSimTest >> testResetDeleteMobileBodiesOnly [
	self clickElementById: #resetButton.
	self assert: app bodies size equals: 1.
]
