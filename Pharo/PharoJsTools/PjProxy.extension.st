Extension { #name : #PjProxy }

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
	^ self jsBridge: [ : bridge |
		[
			bridge evalMessage: (Message selector: #keys: argument: self)  sentTo: PjCore javascriptName
		] on: Error do: [ ^ #()]
	]
]
