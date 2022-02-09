Extension { #name : #PjProxy }

{ #category : #'*PharoJs-Tools-Inspector' }
PjProxy >> asProxyInfo [

	| pi |
	pi := PjProxyInfo new.
	pi oid: self oid.
	pi globalName: jsName.
	^ pi
]

{ #category : #'*PharoJs-Tools-Inspector' }
PjProxy >> gefFieldValueFor: key [

	^ self jsBridge: [ :bridge | 
		  bridge evalJavascript: jsName , '.' , key ]
]

{ #category : #'*PharoJs-Tools-Inspector' }
PjProxy >> gtInspectorProxyIn: composite [
	<gtInspectorPresentationOrder: 1>
	
	| associations |
	associations := OrderedCollection new.
	self keysForProxy associationsDo: [ :assoc | associations add: assoc ].
	^ composite table
		  title: 'Javascript';
		  display: [ :each | associations ];
		  column: 'Key' evaluated: #key;
		  column: 'Value' evaluated: #value;
		  send: #value
]

{ #category : #'*PharoJs-Tools-Inspector' }
PjProxy >> keysForProxy [

	^ self jsBridge: [ :bridge | 
		  [ 
		  | msg |
		  msg := PjMessageGetKeys newWithId.
		  msg proxyInfo: self asProxyInfo.
		  bridge sendMessageAndWaitForResponse: msg ]
			  on: Error
			  do: [ ^ #(  ) ] ]
]
