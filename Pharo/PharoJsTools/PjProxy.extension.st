Extension { #name : #PjProxy }

{ #category : #'*PharoJsTools-Inspector' }
PjProxy >> asProxyInfo [
	| pi |
	pi := PjProxyInfo new.
	pi oid: self oid.
	pi globalName: jsName.
	^ pi
]

{ #category : #'*PharoJsTools-Inspector' }
PjProxy >> gefFieldValueFor: key [
	^ self jsBridge: [ : bridge | 
		bridge evalJavascript: jsName,'.',key
	]
]

{ #category : #'*PharoJsTools-Inspector' }
PjProxy >> gtInspectorProxyIn: composite [
	<gtInspectorPresentationOrder: 1>
	| associations |
	associations := OrderedCollection new.
	self keysForProxy associationsDo: [: assoc | associations add: assoc].
	^(composite table)
		title: 'Javascript';
		display: [:each | associations ];
		column: 'Key' evaluated: #key;
		column: 'Value' evaluated: #value;
		send: #value.
]

{ #category : #'*PharoJsTools-Inspector' }
PjProxy >> keysForProxy [
	^ self
		jsBridge: [ :bridge | 
			[ | msg |
			msg := PjMessageGetKeys newWithId.
			msg proxyInfo: self asProxyInfo.
			bridge sendMessageAndWaitForResponse: msg ]
				on: Error
				do: [ ^ #() ] ]
]
