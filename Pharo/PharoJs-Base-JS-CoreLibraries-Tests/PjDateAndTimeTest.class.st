Class {
	#name : #PjDateAndTimeTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Objects'
}

{ #category : #tests }
PjDateAndTimeTest >> testConversion [

	self assertEquivalent: [ 
		(DateAndTime fromString: '2022-01-02T12:30:21-04:00') getTime ].
	self assertEquivalent: [ '2022-01-02T12:30:21-04:00' printString ].
	self assertEquivalent: [ 
		" works because both Smalltalk and Javascript default to local timezone - see testWeirdTimezoneBug for case with timezone" 
		(DateAndTime fromString: '2022-01-02T12:30:21') printString ]
]

{ #category : #tests }
PjDateAndTimeTest >> testWeirdTimezoneBug [
<expectedFailure>	
	" will never work everywhere because Javascript normalizes to the current timezone "
	self assertEquivalent: [ 
		(DateAndTime fromString: '2022-01-02T12:30:21-04:00') printString ]
]
