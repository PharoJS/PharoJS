"
This example was first introduced durint a talk given at the ESUG 2018 conference.
It shows how to use an existing JS library by relying on the matters.js library
https://brm.io/matter-js/
"
Class {
	#name : #PhysicsSim,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'engine'
	],
	#category : #'PharoJsExamples-PhysicsSimulation'
}

{ #category : #'initialize - release' }
PhysicsSim >> addInitialBodies [
	| boxA boxB ground |
	boxA := self matterJsRoot Bodies rectangle: 400 y: 200 width: 80 height: 80.
	boxB := self matterJsRoot Bodies rectangle: 450 y: 50 width: 80 height: 80.
	ground := self matterJsRoot Bodies rectangle: 400 y: 610 width: 810 height: 60 options: {#isStatic -> true} asJsObject.
	self matterJsRoot World add: engine world bodies: { boxA. boxB. ground }
]

{ #category : #accessing }
PhysicsSim >> bodies [
	^ engine world bodies
]

{ #category : #'initialize - release' }
PhysicsSim >> createAndStartEngine [
	| runner |
	engine := self matterJsRoot Engine create.
	runner := self matterJsRoot Runner create.
	self matterJsRoot Runner run: runner with: engine
]

{ #category : #'initialize - release' }
PhysicsSim >> initialize [
	super initialize.
	self createAndStartEngine.
	self setupAndStartRendering.
	self addInitialBodies.
	self onClick: #resetButton do: [ 
		self matterJsRoot World clear: engine world keepStatic: true]
]

{ #category : #'initialize - release' }
PhysicsSim >> matterJsRoot [
	^ window Matter
]

{ #category : #'initialize - release' }
PhysicsSim >> setupAndStartRendering [
	| render simulationView |
	simulationView := self elementAt: #simulationView.
	render := self matterJsRoot Render create: 
		{#element -> simulationView.
		#engine -> engine.
		#options -> {#width -> 800.
					#height -> 600.
					#wireframes -> false.
					#background -> 'transparent'}} asJsObject.
	self matterJsRoot Render run: render


]
