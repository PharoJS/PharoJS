Extension { #name : #PjApplication }

{ #category : #'*PharoJsTools-Playground' }
PjApplication classSide >> playground [
	<pharoJsSkip>
	^ self bridge playground
]

{ #category : #'*PharoJsTools-Playground' }
PjApplication classSide >> playgroundInitialContent [
	<pharoJsSkip>
	^	'bridge evalBlock: [ PjLoadForTest fortyTwo ]. " loads the referenced classes and executes the block "', String cr
		,'bridge evalBlock: [ 42 inspect ].', String cr
		,'bridge loadClass: PjLoadForTest. " reloads methods "', String cr
"		,'bridge evalBlock: [ Math sin: 1 ].', String cr
"
]

{ #category : #'*PharoJsTools-Playground' }
PjApplication classSide >> playgroundLoadClassesContent [
	<pharoJsSkip>
	| classes |
	classes := (SystemNavigation default allClassesInPackageNamed: self category) reject: #isTestCase.
	^ '" inspect the following to examine the running app "',String cr
		,'bridge evalBlock: [ ',self name,' currentInstance ].',String cr
		,'" do the following to re-load classes if you edit them "',String cr
		,(String cr join: (classes collect: [: class | 'bridge loadClass: ',class name,'.']))
]

{ #category : #'*PharoJsTools-Playground' }
PjApplication classSide >> playgroundWithoutLaunch [
	<pharoJsSkip>
	self bridge playgroundWithoutLaunch
]

{ #category : #'*PharoJsTools-Playground' }
PjApplication classSide >> playgroundWithoutLaunchOnUrl: aString [
	<pharoJsSkip>
	^ self bridge playgroundWithoutLaunchOnUrl: aString
]

{ #category : #'*PharoJsTools-Playground' }
PjApplication classSide >> title [
	<pharoJsSkip>
	^ self name
]
