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
PjProxy >> inspectionItems: aBuilder [

<inspectorPresentationOrder: 1 title: 'Javascript'>
	| associations |
	associations := OrderedCollection new.
	self keysForProxy associationsDo: [ :assoc | associations add: assoc ].
	^ aBuilder newTable
		  addColumn: (SpStringTableColumn
				   title: 'Key'
				   evaluated: [ :each |
					   StObjectPrinter asTruncatedTextFrom: each key ]) beSortable;
		  addColumn: (SpStringTableColumn
				   title: 'Value'
				   evaluated: [ :each |
					   StObjectPrinter asTruncatedTextFrom: each value ]) beSortable;
		  items: (associations collect: [ :e |
					   StInspectorAssociationNode hostObject: e ]);
		  yourself
	
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
