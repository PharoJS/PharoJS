Extension { #name : #PjMinimalWebApplication }

{ #category : #'*PharoJs-Tools' }
PjMinimalWebApplication class >> writePlaygroundContentsOn: str [

	<pharoJsSkip>
	super writePlaygroundContentsOn: str.
	str
		<< '"Sample code:"';
		cr;
		<< 'console dir: document.';
		cr;
		<< 'document fonts. " inspect this "';
		cr;
		<< 'document body style backgroundColor: ''#fee''.';
		cr
]
