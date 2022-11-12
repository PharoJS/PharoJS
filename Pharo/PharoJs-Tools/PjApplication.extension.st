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
