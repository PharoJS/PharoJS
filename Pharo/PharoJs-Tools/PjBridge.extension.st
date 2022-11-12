Extension { #name : #PjBridge }

{ #category : #'*PharoJs-Tools' }
PjBridge >> playground [

	^ PjPlayground openFor: self

]

{ #category : #'*PharoJs-Tools' }
PjBridge >> writePlaygroundContentsOn: str [

	str
		<< $";
		<<
			'Connection established with Javascript via PharoJS bridge listening on port ';
		print: self port;
		<< $.;
		<< $";
		cr;
		cr.
	self client writePlaygroundContentsOn: str
]
