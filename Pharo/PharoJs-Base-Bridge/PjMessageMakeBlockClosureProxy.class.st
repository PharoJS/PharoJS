Class {
	#name : #PjMessageMakeBlockClosureProxy,
	#superclass : #PjMessageS2c,
	#instVars : [
		'stopPropagation',
		'includeEventTarget'
	],
	#category : #'PharoJs-Base-Bridge-Messages'
}

{ #category : #public }
PjMessageMakeBlockClosureProxy >> evaluateInContext: aMessageContext [
	| aProxyInfo responseMsg |
	aProxyInfo := PjProxyManager
		makeBlockClosureProxy: self includeEventTarget
		stopPropagation: self stopPropagation
		for: aMessageContext websocketDelegate.
	responseMsg := PjMessageEvaluationResponse newWithContents: aProxyInfo.
	responseMsg inResponseToId: self id.
	aMessageContext websocketDelegate tryToSendMessage: responseMsg
]

{ #category : #accessing }
PjMessageMakeBlockClosureProxy >> includeEventTarget [
	^ includeEventTarget
]

{ #category : #accessing }
PjMessageMakeBlockClosureProxy >> includeEventTarget: anObject [
	includeEventTarget := anObject
]

{ #category : #'initialize-release' }
PjMessageMakeBlockClosureProxy >> initialize [
	super initialize.
	stopPropagation := true.
	includeEventTarget := false
]

{ #category : #accessing }
PjMessageMakeBlockClosureProxy >> stopPropagation [
	^ stopPropagation
]

{ #category : #accessing }
PjMessageMakeBlockClosureProxy >> stopPropagation: anObject [
	stopPropagation := anObject
]
