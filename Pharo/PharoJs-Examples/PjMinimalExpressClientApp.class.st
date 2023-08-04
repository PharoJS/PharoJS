Class {
	#name : #PjMinimalExpressClientApp,
	#superclass : #PjFileBasedWebApp,
	#traits : 'PjTWebClientApp',
	#classTraits : 'PjTWebClientApp classTrait',
	#category : #'PharoJs-Examples-ExpressJS'
}

{ #category : #initialization }
PjMinimalExpressClientApp class >> serverAppClass [

	<pharoJsSkip>
	^ PjMinimalExpressApp
]

{ #category : #initialization }
PjMinimalExpressClientApp >> data [

	^ (self elementAt: #dataInput) value
]

{ #category : #initialization }
PjMinimalExpressClientApp >> data: aString [

	(self elementAt: #dataDisplaySpan) textContent: aString
]

{ #category : #initialization }
PjMinimalExpressClientApp >> initialize [

	super initialize.
	self
		onClick: #getDataButton
		do: [ self get: '/data' withTextDo: [ :text | self data: text ] ].
	self
		onClick: #postDataButton
		do: [ self post: '/data' text: self data ]
]
