Class {
	#name : #PhysicsSimTest,
	#superclass : #PjWebAppTestCase,
	#category : #'PharoJs-Examples-Tests-PhysicsSimulation'
}

{ #category : #'suite parameters' }
PhysicsSimTest class >> appClass [
	^PhysicsSim
]

{ #category : #tests }
PhysicsSimTest >> testAppInitialSetup [
	self assert: app bodies size equals: 3
]

{ #category : #tests }
PhysicsSimTest >> testResetDeleteMobileBodiesOnly [
	self clickElementById: #resetButton.
	self assert: app bodies size equals: 1.
]
