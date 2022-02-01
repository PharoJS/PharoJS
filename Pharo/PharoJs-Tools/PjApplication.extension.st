Extension { #name : #PjApplication }

{ #category : #'*PharoJs-Tools-Playground' }
PjApplication class >> classSubclassResponsibilitySet [
	| set |
	set := self == PjApplication ifTrue: [ Set new ] ifFalse: [ self superclass classSubclassResponsibilitySet ].
	self class methods do: [:cm | | selector |
		selector := cm selector.
		(cm sendsSelector: #subclassResponsibility) ifTrue: [
				set add: selector
			] ifFalse: [
				set remove: selector ifAbsent: [ ]
			]]..
	^ set
]

{ #category : #'*PharoJs-Tools-Playground' }
PjApplication class >> isAbstract [
	^ self subclassResponsibilitySet isNotEmpty or: [
			self classSubclassResponsibilitySet isNotEmpty
		]
]

{ #category : #'*PharoJs-Tools-Playground' }
PjApplication class >> pharoPlayground [
	<pharoJsSkip>
	^ self bridge pharoPlayground
]

{ #category : #'*PharoJs-Tools-Playground' }
PjApplication class >> playground [
	<pharoJsSkip>
	^ self bridge playground
]

{ #category : #'*PharoJs-Tools-Playground' }
PjApplication class >> playgroundInitialContent [
	<pharoJsSkip>
	^	'bridge evalBlock: [ PjLoadForTest fortyTwo ]. " loads the referenced classes and executes the block "', String cr
		,'bridge evalBlock: [ 42 inspect ].', String cr
		,'bridge loadClass: PjLoadForTest. " reloads methods "', String cr
"		,'bridge evalBlock: [ Math sin: 1 ].', String cr
"
]

{ #category : #'*PharoJs-Tools-Playground' }
PjApplication class >> playgroundLoadClassesContent [
	<pharoJsSkip>
	| classes |
	classes := (SystemNavigation default allClassesInPackageNamed: self category) reject: #isTestCase.
	^ '" inspect the following to examine the running app "',String cr
		,'bridge evalBlock: [ ',self name,' currentInstance ].',String cr
		,'" do the following to re-load classes if you edit them "',String cr
		,(String cr join: (classes collect: [: class | 'bridge loadClass: ',class name,'.']))
]

{ #category : #'*PharoJs-Tools-Playground' }
PjApplication class >> playgroundWithoutLaunch [
	<pharoJsSkip>
	self bridge playgroundWithoutLaunch
]

{ #category : #'*PharoJs-Tools-Playground' }
PjApplication class >> playgroundWithoutLaunchOnUrl: aString [
	<pharoJsSkip>
	^ self bridge playgroundWithoutLaunchOnUrl: aString
]

{ #category : #'*PharoJs-Tools-Playground' }
PjApplication class >> subclassResponsibilitySet [
	| set |
	set := self == PjApplication ifTrue: [ Set new ] ifFalse: [ self superclass subclassResponsibilitySet ].
	self methods do: [:cm | | selector |
		selector := cm selector.
		(cm sendsSelector: #subclassResponsibility) ifTrue: [
				set add: selector
			] ifFalse: [
				set remove: selector ifAbsent: [ ]
			]]..
	^ set
]

{ #category : #'*PharoJs-Tools-Playground' }
PjApplication class >> title [
	<pharoJsSkip>
	^ self name
]
