Class {
	#name : #PjMessageSetEventListener,
	#superclass : #PjMessageS2c,
	#instVars : [
		'targetProxyInfo',
		'listenerProxyInfo',
		'eventName'
	],
	#category : #'PharoJs-Base-Bridge-Messages'
}

{ #category : #public }
PjMessageSetEventListener >> evaluateInContext: aMessageContext [
	| result responseMsg |
	result := self evaluateInContextPrivate: aMessageContext.
	responseMsg := PjMessageEvaluationResponse
		newWithContents: result proxyResponse.
	responseMsg inResponseToId: self id.
	aMessageContext websocketDelegate tryToSendMessage: responseMsg
]

{ #category : #public }
PjMessageSetEventListener >> evaluateInContextPrivate: aMessageContext [
	| targetObject listener fullTriggerName oldlistener |
	fullTriggerName := 'on' , self eventName.
	targetObject := self targetProxyInfo getJsObject.
	listener := self listenerProxyInfo ifNotNil: [ :pi | pi getJsObject ].
	oldlistener := targetObject instVarNamed: fullTriggerName.
	targetObject instVarNamed: fullTriggerName put: listener.
	listener
		ifNotNil: [ (listener hasOwnProperty: '$PjRefCount')
				ifTrue: [ | currRefCnt |
					currRefCnt := listener instVarNamed: '$PjRefCount'.
					listener instVarNamed: '$PjRefCount' put: currRefCnt + 1 ] ].
	oldlistener
		ifNotNil: [ | currRefCnt |
			currRefCnt := oldlistener instVarNamed: '$PjRefCount'.
			currRefCnt > 0
				ifTrue: [ oldlistener instVarNamed: '$PjRefCount' put: currRefCnt - 1.
					(oldlistener instVarNamed: '$PjRefCount') == 0
						ifTrue: [ oldlistener instVarNamed: '$PjProxyRemove' put: true.
							^ oldlistener ] ] ].
	^ 'true'
]

{ #category : #accessing }
PjMessageSetEventListener >> eventName [
	^ eventName
]

{ #category : #accessing }
PjMessageSetEventListener >> eventName: anObject [
	eventName := anObject
]

{ #category : #accessing }
PjMessageSetEventListener >> listenerProxyInfo [
	^ listenerProxyInfo
]

{ #category : #accessing }
PjMessageSetEventListener >> listenerProxyInfo: anObject [
	listenerProxyInfo := anObject
]

{ #category : #accessing }
PjMessageSetEventListener >> targetProxyInfo [
	^ targetProxyInfo
]

{ #category : #accessing }
PjMessageSetEventListener >> targetProxyInfo: anObject [
	targetProxyInfo := anObject
]
