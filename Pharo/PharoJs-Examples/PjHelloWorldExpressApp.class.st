Class {
	#name : #PjHelloWorldExpressApp,
	#superclass : #PjExpressApp,
	#instVars : [
		'name'
	],
	#category : #'PharoJs-Examples-ExpressJS'
}

{ #category : #initialization }
PjHelloWorldExpressApp >> greetings [
	^String streamContents: [ : str |
		str 
			<< 'ExpressJS says hello'.
	name ifNotNil: [ str
		space; 
		<< name ].
	str << $!
	]
]

{ #category : #initialization }
PjHelloWorldExpressApp >> initialize [

	super initialize.
	server get: '/name' handler: [ :req :res | res send: name ].
	server
		get: '/greetings'
		handler: [ :req :res | res send: self greetings ].
	server
		post: '/name'
		handler: [ :req :res | 
		self handlePostNameRequest: req response: res ]
]
