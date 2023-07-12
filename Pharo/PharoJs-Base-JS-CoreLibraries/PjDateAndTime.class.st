"
DateAndTime representation as JavaScript Date
"
Class {
	#name : #PjDateAndTime,
	#superclass : #Object,
	#traits : 'PjTDateAndTime',
	#classTraits : 'PjTDateAndTime classTrait',
	#instVars : [
		'offset'
	],
	#pools : [
		'ChronologyConstants'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Chronology'
}

{ #category : #'instance creation' }
PjDateAndTime class >> basicfromString: aString [
	<javascript: 'return new this(aString)'>
]

{ #category : #'instance creation' }
PjDateAndTime class >> fromString: aString [

	| offset |
	'[-+](\d\d)\:(\d\d)$' asRegex matchesIn: aString do: [ :match | 
		| sign hoursAndMinutes |
		sign := (match includes: $+)
			        ifTrue: [ 1 ]
			        ifFalse: [ -1 ].
		hoursAndMinutes := '(\d\d)' asRegex matchesIn: match.
		offset := (sign * hoursAndMinutes first asNumber * 60
		           + (sign * hoursAndMinutes second asNumber)) minutes ].
	^ (self basicfromString: aString)
		  offset: offset;
		  yourself
]

{ #category : #'pharoJs support' }
PjDateAndTime class >> javascriptName [
	<pharoJsSkip>
	^ #Date
]

{ #category : #'pharoJs support' }
PjDateAndTime class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ { 
		  (DateAndTime class
		   -> #( #todayHour:minute: #tomorrowHour:minute: )).
		  (DateAndTime -> #( daysInYear )) }
]

{ #category : #'instance creation' }
PjDateAndTime class >> now [
	<javascript: 'return new this()'>
]

{ #category : #'instance creation' }
PjDateAndTime class >> todayHour: hour minute: minute second: second [
	"setXXX methods are defined in JS"
	^self new
		setHours: hour;
		setMinutes: minute;
		setSeconds: second;
		yourself
]

{ #category : #'instance creation' }
PjDateAndTime class >> tomorrowHour: hour minute: minute second: second [
	^(self todayHour: hour minute: minute second: second) + 1 day
]

{ #category : #'instance creation' }
PjDateAndTime class >> year: year month: month1To12 day: day1To31 hour: hour minute: minute second: second [
	<javascript: 'return new this(year, month1To12 - 1, day1To31, hour, minute, second)'>
]

{ #category : #arithmetics }
PjDateAndTime >> + otherObject [
	^otherObject addDateAndTime: self
]

{ #category : #arithmetics }
PjDateAndTime >> - anObject [
	^anObject subtractFromDateAndTime: self
]

{ #category : #converting }
PjDateAndTime >> asDateAndTime [
	^self
]

{ #category : #printing }
PjDateAndTime >> basicPrintString [

	<javascript: 'let d;
	d = [
    "0" + (this.getMonth() + 1),
    "0" + this.getDate(),
    "0" + this.getHours(),
    "0" + this.getMinutes(),
    "0" + this.getSeconds()
  ].map(component => component.slice(-2)); // take last 2 digits of every component

  // join the components into date
  return ("000"+ this.getFullYear()).slice(-4)+"-"+d.slice(0, 2).join("-")+ "T" + d.slice(2,5).join(":")'>

 
]

{ #category : #arithmetics }
PjDateAndTime >> basicSubtractFromDateAndTime: other [
	<javascript: 'return other - this;'>
]

{ #category : #accessing }
PjDateAndTime >> dayOfMonth [
	^self getDate
]

{ #category : #accessing }
PjDateAndTime >> dayOfWeek [
	^self getDay + 1
]

{ #category : #accessing }
PjDateAndTime >> hour [
	^self hour24
]

{ #category : #accessing }
PjDateAndTime >> hour12 [
	| hour24 |
	hour24 := self hour24.
	hour24 = 0 ifTrue: [ ^12 ].
	hour24 > 12 ifTrue: [ ^hour24 - 12 ].
	^hour24
]

{ #category : #accessing }
PjDateAndTime >> hour24 [
	^self getHours
]

{ #category : #accessing }
PjDateAndTime >> milliSecond [
	^self getMilliseconds
]

{ #category : #accessing }
PjDateAndTime >> minute [
	^self getMinutes
]

{ #category : #accessing }
PjDateAndTime >> monthIndex [
	^self getMonth + 1
]

{ #category : #accessing }
PjDateAndTime >> monthIndex: anInteger [
	^self month: anInteger - 1
]

{ #category : #accessing }
PjDateAndTime >> offset [

	^ offset ifNil: [ offset := (-1 * self getTimezoneOffset) minutes ]
]

{ #category : #accessing }
PjDateAndTime >> offset: aDuration [

	offset := aDuration
]

{ #category : #printing }
PjDateAndTime >> printOn: str [

	str << (self getTimezoneOffset minutes addDateAndTime:
		 (self offset addDateAndTime: self)) basicPrintString.
	self offset printStringAsTimzoneOn: str
]

{ #category : #accessing }
PjDateAndTime >> second [
	^self getSeconds
]

{ #category : #arithmetics }
PjDateAndTime >> subtractFromDateAndTime: aDateAndTime [
	^Duration milliSeconds: (self basicSubtractFromDateAndTime: aDateAndTime)
]

{ #category : #accessing }
PjDateAndTime >> year [
	^self getFullYear
]
