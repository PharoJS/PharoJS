Class {
	#name : #PjDateAndTimeTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Objects'
}

{ #category : #tests }
PjDateAndTimeTest >> testConversion [

	| today todayString |
	self assertEquivalent: [ 
		(DateAndTime fromString: '2022-01-02T12:30:21-04:00') getTime ].
	self assertEquivalent: [ 
		(DateAndTime fromString: '2022-01-02T12:30:21-04:00') printString ].
	self assertEquivalent: [ 
		(DateAndTime fromString: '2022-01-02T12:30:21-00:00') printString ].
	self assertEquivalent: [ 
		(DateAndTime fromString: '2022-01-02T12:30:21+04:00') printString ].
	today := DateAndTime today.
	todayString := String streamContents: [ :str | 
		               BasicDatePrinter default
			               printYMD: today
			               withLeadingSpace: false
			               on: str ].
	self assertEquivalent: [ " works because both Smalltalk and Javascript default to local timezone - see testWeirdTimezoneBug for case with timezone" 
		(DateAndTime fromString: todayString , 'T12:30:21') printString ]
]
