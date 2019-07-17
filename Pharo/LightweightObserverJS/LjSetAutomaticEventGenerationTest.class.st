Class {
	#name : #LjSetAutomaticEventGenerationTest,
	#superclass : #LjElasticCollectionAutomaticEventGenerationTest,
	#category : #'LightweightObserverJS-Tests'
}

{ #category : #testing }
LjSetAutomaticEventGenerationTest >> resetCollection [
	self evalBlock: [ subject collection: Set new ]
]

{ #category : #testing }
LjSetAutomaticEventGenerationTest >> testAddRedundantElement [
	window instVarNamed: #additionCount put: 0.
	self evalBlock: [subject afterAddToCollection: #collection do: [ window additionCount: window additionCount + 1]].
	subject collection add: #monday.
	self assert: window additionCount equals: 1.
	subject collection add: #monday.
	self assert: window additionCount equals: 1.

]
