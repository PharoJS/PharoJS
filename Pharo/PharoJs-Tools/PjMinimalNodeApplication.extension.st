Extension { #name : #PjMinimalNodeApplication }

{ #category : #'*PharoJs-Tools' }
PjMinimalNodeApplication class >> writePlaygroundContentsOn: str [

	<pharoJsSkip>
	super writePlaygroundContentsOn: str.
	str
		<< '"Sample code:"';
		cr;
		<< 'console log: ''hello''.';
		cr;
		<< 'global. " inspect this "';
		cr
]
