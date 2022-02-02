Class {
	#name : #PjMessageGetKeysResponse,
	#superclass : #PjMessageC2sInResponseTo,
	#category : #'PharoJs-Base-Bridge-Messages'
}

{ #category : #public }
PjMessageGetKeysResponse >> getValueWithBridge: aBridge [

	^ self contents
]

{ #category : #printing }
PjMessageGetKeysResponse >> logDescription [

	^ String streamContents: [ :ws | 
		  ws
			  nextPutAll: self class name;
			  nextPutAll: ' id: ';
			  nextPutAll: self id asString;
			  nextPutAll: ' inResponseToId: ';
			  nextPutAll: (self inResponseToId
					   ifNotNil: [ :aNumber | aNumber asString ]
					   ifNil: [ '-' ]);
			  nextPutAll: ' contents: ';
			  nextPutAll: self contents size asString;
			  nextPutAll: ' key-value pairs' ]
]

{ #category : #printing }
PjMessageGetKeysResponse >> printOn: ws [
	<pharoJsSkip>
	
	super printOn: ws.
	ws space.
	ws << 'ir2id: '.
	ws << (self inResponseToId ifNil: [ '-' ]).
	ws space.
	ws << self contents
]
