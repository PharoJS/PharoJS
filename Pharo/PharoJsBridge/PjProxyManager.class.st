Class {
	#name : #PjProxyManager,
	#superclass : #Object,
	#classVars : [
		'currentId'
	],
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #'instance creation' }
PjProxyManager class >> nextId [
	currentId := currentId ifNil: [ 1 ] ifNotNil: [ :id | id + 1 ].
	^ currentId
]
