Class {
	#name : #PjRubricSmalltalkTextModel,
	#superclass : #GLMRubricSmalltalkTextModel,
	#category : #'PharoJsTools-Playground'
}

{ #category : #rendering }
PjRubricSmalltalkTextModel >> appendVariableBinding: anAssociationList [
	anAssociationList ifNotNil: [
		anAssociationList do: [ :anAssociation | 
			self variableBindings add: anAssociation ] ]
]
