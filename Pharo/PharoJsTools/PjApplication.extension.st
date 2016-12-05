Extension { #name : #PjApplication }

{ #category : #'*PharoJsTools-Playground' }
PjApplication classSide >> playground [
	<pharoJsSkip>
	self bridge playground
]

{ #category : #'*PharoJsTools-Playground' }
PjApplication classSide >> playgroundInitialContent [
	<pharoJsSkip>
	^	'" a bridge is already open and globals are defined"', String cr
		,'bridge evalBlock: [ PjLoadForTest fortyTwo ]. " loads the referenced classes and executes the block "', String cr
		,'bridge loadClass: PjLoadForTest. " reloads methods "', String cr
		,'console dir: document.', String cr
		,'document fonts. " inspect this "', String cr
		,'document body style backgroundColor: ''#fee''.', String cr

]

{ #category : #'*PharoJsTools-Playground' }
PjApplication classSide >> title [
	<pharoJsSkip>
	^ self name
]
