Extension { #name : #PjMinimalFileBasedWebApp }

{ #category : #'*PharoJs-Tools' }
PjMinimalFileBasedWebApp class >> writePlaygroundContentsOn: str [

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
