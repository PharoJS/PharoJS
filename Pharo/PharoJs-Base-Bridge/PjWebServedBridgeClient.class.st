Class {
	#name : #PjWebServedBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#traits : 'PjTWebBridgeClient',
	#classTraits : 'PjTWebBridgeClient classTrait',
	#instVars : [
		'urlString'
	],
	#category : #'PharoJs-Base-Bridge-Client-Kernel'
}

{ #category : #'accessing - defaults' }
PjWebServedBridgeClient >> defaultAppClass [

	^ PjMinimalWebApplication
]

{ #category : #accessing }
PjWebServedBridgeClient >> urlString [

	^ urlString
]

{ #category : #accessing }
PjWebServedBridgeClient >> urlString: anObject [

	urlString := anObject
]
