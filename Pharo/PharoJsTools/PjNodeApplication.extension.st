Extension { #name : #PjNodeApplication }

{ #category : #'*PharoJsTools-Playground' }
PjNodeApplication class >> playgroundInitialContent [
	<pharoJsSkip>
	^	super playgroundInitialContent
		,'console log: ''hello''.', String cr
		,'global. " inspect this "', String cr
]
