Extension { #name : #PjWebApplication }

{ #category : #'*PharoJsTools-Playground' }
PjWebApplication classSide >> playgroundInitialContent [
	<pharoJsSkip>
	^	super playgroundInitialContent
		,'console dir: document.', String cr
		,'document fonts. " inspect this "', String cr
		,'document body style backgroundColor: ''#fee''.', String cr

]
