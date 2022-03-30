Class {
	#name : #PjDateAndTimeTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Objects'
}

{ #category : #tests }
PjDateAndTimeTest >> testConversion [
"Parsing a date-time-string is handled differently:
    for Pharo, the timezone is part of the object. If there is a timezone specified, Pharo remembers that timezone, else it uses the current local timezone.
    browsers parse the string into a second offset integer relative to UTC - no timezone is remembered

When formatting a date:

    Pharo uses the timezone in the object
    browsers use the local timezone on the date/time encoded in the integer so daylight saving time is as of that date/time

This means that for todays date (and a time after 03:00), the round-trip will be the same without a timezone. With a timezone other than the current one, the strings will represent the same time, but won't be the same strings.

For other dates, with or without a timezone, the strings may differ because the browser will use the timezone in effect on that date/time (time could be relevant if daylight savings time starts or ends that day), while Pharo will use the encoded timezone (which would be the current one if not specified on the parse).
"

	| nowString nowRawString nowStringNoTimeZone|
	self assertEquivalent: [ 
		(DateAndTime fromString: '2022-01-02T12:30:21-04:00') getTime ].
	
	nowRawString := DateAndTime now asString.	
	nowStringNoTimeZone := String streamContents: [: str |
		str << (nowRawString first: 11);
			<< '12:36:57'.
		].
	self assertEquivalent: [ 
		(DateAndTime fromString: nowStringNoTimeZone) printString ].
	nowString := nowStringNoTimeZone , (nowRawString last: 6).
	self assertEquivalent: [ 
		(DateAndTime fromString: nowString) printString ].

]
