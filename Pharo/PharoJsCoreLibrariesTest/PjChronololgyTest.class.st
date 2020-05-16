Class {
	#name : #PjChronololgyTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsCoreLibrariesTest-Objects'
}

{ #category : #testing }
PjChronololgyTest >> setUp [
	super setUp.
	self bridge
		loadAllClasses:
			{
			Time.
			Duration.
			DateAndTime}
]

{ #category : #testing }
PjChronololgyTest >> testDateAndTimeArithmetic [
	self evalBlock: [|reference|
		reference := DateAndTime todayHour: 14 minute: 59 second: 33.
		window instVarNamed: #reference put: reference].	
	self evalBlock: [
		|plus1Sec| 
		plus1Sec := window reference +  1 second.
		window instVarNamed: #plus1Sec put: plus1Sec].	
	self assertEquivalent: [window plus1Sec hour24 = 14].
	self assertEquivalent: [window plus1Sec hour = 14].
	self assertEquivalent: [window plus1Sec hour12 = 2].
	self assertEquivalent: [window plus1Sec minute = 59].
	self assertEquivalent: [window plus1Sec second = 34].

]

{ #category : #testing }
PjChronololgyTest >> testDateAndTimeCreation [
	self evalBlock: [|today tomorrow|
		today := DateAndTime todayHour: 14 minute: 59 second: 34.
		tomorrow := DateAndTime tomorrowHour: 14 minute: 59 second: 34.
		window instVarNamed: #today put: today.
		window instVarNamed: #tomorrow put: tomorrow.
		].	
	{window today. window tomorrow} do: [: each |
		self assert: each hour24 = 14.
		self assert: each hour = 14.
		self assert: each hour12 = 2.
		self assert: each minute = 59.
		self assert: each second = 34.
	].
	self assert: window today year equals: Date today year.
	self assert: window today monthIndex equals: Date today monthIndex.
	self assert: window today dayOfMonth equals: Date today dayOfMonth.
	self assert: window today dayOfWeek equals: Date today dayOfWeek.
	self assert: window tomorrow year equals: Date tomorrow year.
	self assert: window tomorrow monthIndex equals: Date tomorrow monthIndex.
	self assert: window tomorrow dayOfMonth equals: Date tomorrow dayOfMonth.
	self assert: window tomorrow dayOfWeek equals: Date tomorrow dayOfWeek.
	
]

{ #category : #testing }
PjChronololgyTest >> testDuration [
	self assertBlock: [ Duration zero class == Duration ].
	self assertEquivalent: [ Duration zero days].
	self assertEquivalent: [ Duration zero hours].
	self assertEquivalent: [ Duration zero minutes].
	self assertEquivalent: [ 1 month monthsCount].

]

{ #category : #testing }
PjChronololgyTest >> testTime [
	self assertBlock: [ Time now class == Time ].
	self assertEquivalent: [ (Time hour: 5 minute: 30) asDateAndTime dayOfMonth].
	self assertEquivalent: [ (Time hour: 5 minute: 30) asDateAndTime monthIndex].
	self assertEquivalent: [ (Time hour: 5 minute: 30) asDateAndTime year].
	self assertEquivalent: [ Time now hour].
	self assertEquivalent: [ Time now hour].
	self assertEquivalent: [ Time now hour12].
	self assertEquivalent: [ Time now hour24].
	self assertEquivalent: [ Time now minute].
	self assert: [ (Time hour: 1 minute: 1 second: 13) asSeconds ] evaluatesTo: 3673.
	self assert: [ (Time now seconds: 25) hour24 ] evaluatesTo: 0.
	self assert: [ (Time now seconds: 25) minute ] evaluatesTo: 0.
	self assert: [ (Time now seconds: 25) second ] evaluatesTo: 25.
	self assert: [ (Time now seconds: 625) hour24 ] evaluatesTo: 0.
	self assert: [ (Time now seconds: 625) minute ] evaluatesTo: 10.
	self assert: [ (Time now seconds: 625) second ] evaluatesTo: 25.
	self assertEquivalent: [ Time noon meridianAbbreviation].
	self assertEquivalent: [ Time noon hour12].
	self assertEquivalent: [ Time noon hour24].
	self assertEquivalent: [ Time midnight meridianAbbreviation].
	self assertEquivalent: [ Time midnight hour12].
	self assertEquivalent: [ Time midnight hour24].
	self assertEquivalent: [ (Time hour: 0 minute: 0 second: 0) hour12 ].
	self assertEquivalent: [ (Time hour: 1 minute: 0 second: 0) hour12 ].
	self assertEquivalent: [ (Time hour: 11 minute: 0 second: 0) hour12 ].
	self assertEquivalent: [ (Time hour: 12 minute: 0 second: 0) hour12 ].
	self assertEquivalent: [ (Time hour: 13 minute: 0 second: 0) hour12 ].
	self assertEquivalent: [ (Time hour: 23 minute: 0 second: 0) hour12 ].

]
