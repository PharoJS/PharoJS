Class {
	#name : #PjHelloWorldExpressApp,
	#superclass : #PjExpressApp,
	#category : #'PharoJs-Examples-ExpressJS'
}

{ #category : #initialization }
PjHelloWorldExpressApp >> initialize [

	super initialize.
	server get: '/' handler: [ :req :res | res send: 'Hello World!' ]
]
