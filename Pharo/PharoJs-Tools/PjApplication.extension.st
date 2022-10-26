Extension { #name : #PjApplication }

{ #category : #'*PharoJs-Tools' }
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

{ #category : #'*PharoJs-Tools' }
PjApplication class >> isAbstract [
	^ self subclassResponsibilitySet isNotEmpty or: [
			self classSubclassResponsibilitySet isNotEmpty
		]
]

{ #category : #'*PharoJs-Tools' }
PjApplication class >> playground [
	<pharoJsSkip>
	^ self bridge playground
]

{ #category : #'*PharoJs-Tools' }
PjApplication class >> playgroundLoadClassesContent [
	<pharoJsSkip>
	| classes |
	classes := (SystemNavigation default allClassesInPackageNamed: self category) reject: #isTestCase.
	^ '" inspect the following to examine the running app "',String cr
		,'bridge evalBlock: [ ',self name,' currentInstance ].',String cr
		,'" do the following to re-load classes if you edit them "',String cr
		,(String cr join: (classes collect: [: class | 'bridge loadClass: ',class name,'.']))
]

{ #category : #'*PharoJs-Tools' }
PjApplication class >> playgroundWithoutLaunch [
	<pharoJsSkip>
	self bridge playgroundWithoutLaunch
]

{ #category : #'*PharoJs-Tools' }
PjApplication class >> playgroundWithoutLaunchOnUrl: aString [
	<pharoJsSkip>
	^ self bridge playgroundWithoutLaunchOnUrl: aString
]

{ #category : #'*PharoJs-Tools' }
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

{ #category : #'*PharoJs-Tools' }
PjApplication class >> title [
	<pharoJsSkip>
	^ self name
]

{ #category : #'*PharoJs-Tools' }
PjApplication class >> writePlaygroundContentsOn: str [

	<pharoJsSkip>
	str
		<< $"
		<<
			'PharoJS playground preset bindings including the bridge and JS globals.';
		cr;
		<< 'You can find them all in the bindings menu above.';
		<< $";
		cr;
		cr
]
