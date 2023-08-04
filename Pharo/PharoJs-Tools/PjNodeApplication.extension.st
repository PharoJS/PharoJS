Extension { #name : #PjNodeApplication }

{ #category : #'*PharoJs-Tools' }
PjNodeApplication class >> writePlaygroundContentsOn: str [

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
