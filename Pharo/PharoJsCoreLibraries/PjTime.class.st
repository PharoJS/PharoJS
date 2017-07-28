"
Time in the Javascript world
"
Class {
	#name : #PjTime,
	#superclass : #Object,
	#traits : 'PjTDateAndTime',
	#classTraits : 'PjTDateAndTime classTrait',
	#pools : [
		'ChronologyConstants'
	],
	#category : #'PharoJsCoreLibraries-Chronology'
}

{ #category : #'instance creation' }
PjTime class >> hour: hour minute: minute second: second milliSecond: milliseconds [
	<javascript: '
	var today = new Date();
	return new Date(today.getFullYear(), today.getMonth(), today.getDate(), hour, minute, second, milliseconds);'>
]

{ #category : #'instance creation' }
PjTime class >> hour: hour minute: minute second: second nanoSecond: nanoCount [
	^self hour: hour minute: minute second: second milliSecond: nanoCount // 1000000
]

{ #category : #'pharoJs support' }
PjTime class >> javascriptName [
	<pharoJsSkip>
	^ #Date
]

{ #category : #'pharoJs support' }
PjTime class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	| classSelectors instanceSelectors |
	classSelectors := Time class 
		selectorsInProtocols: #('instance creation' '*PharoExtra-instance creation')  
		exclude: #(now nowLocal fromString: readFrom: hour:minute:second:nanoSecond: seconds:nanoSeconds: seconds: hour:minute:second:milliSecond:). 
	instanceSelectors := Time 
		selectorsInProtocols: #(accessing "adding comparing converting")
		exclude: #(hour12 hour24 minute second).
	^{Time class -> classSelectors.
	Time -> instanceSelectors }
]

{ #category : #clock }
PjTime class >> millisecondClockValue [
	<javascript: 'if(typeof performance=="object") return performance.now();
if(typeof process=="object"){var hr=process.hrtime();return hr[0]*1000+hr[1]/1000000}
return Date.now()'>

]

{ #category : #serialization }
PjTime class >> newFromMaterialized: jsonString [
	<javascript: 'return new Date(jsonString)'>
	
]

{ #category : #'instance creation' }
PjTime class >> now [
	<javascript: 'return new this()'>
]

{ #category : #'instance creation' }
PjTime class >> seconds: seconds [
	^self seconds: seconds nanoSeconds: 0
]

{ #category : #'instance creation' }
PjTime class >> seconds: seconds nanoSeconds: nanoCount [
	"Answer a Time from midnight."
	^self basicNew
		seconds: seconds nanoSeconds: nanoCount;
		yourself

]

{ #category : #converting }
PjTime >> asDateAndTime [
	^self
]

{ #category : #converting }
PjTime >> asSeconds [
	^(self hour24 * 3600) + (self minute * 60) + self seconds
]

{ #category : #accessing }
PjTime >> dayOfMonth [
	^self getDate
]

{ #category : #accessing }
PjTime >> dayOfWeek [
	^self getDay + 1
]

{ #category : #accessing }
PjTime >> hour [
	^self hour24

]

{ #category : #accessing }
PjTime >> hour12 [
	| hour24 |
	hour24 := self hour24.
	hour24 = 0 ifTrue: [ ^12 ].
	hour24 > 12 ifTrue: [ ^hour24 - 12 ].
	^hour24
]

{ #category : #accessing }
PjTime >> hour24 [
	^self getHours
]

{ #category : #accessing }
PjTime >> milliSecond [
	^self getMilliseconds
]

{ #category : #accessing }
PjTime >> minute [
	^self getMinutes
]

{ #category : #accessing }
PjTime >> monthIndex [
	^self getMonth + 1
]

{ #category : #accessing }
PjTime >> monthIndex: anInteger [
	^self month: anInteger - 1
]

{ #category : #accessing }
PjTime >> second [
	^self getSeconds
]

{ #category : #private }
PjTime >> seconds: secondCount [
	| minuteSecondsCount |
	self setHours: (secondCount quo: SecondsInHour).
	minuteSecondsCount := secondCount rem: SecondsInHour.
	self setMinutes: (minuteSecondsCount quo: SecondsInMinute).
	self setSeconds: (minuteSecondsCount rem: SecondsInMinute).

]

{ #category : #private }
PjTime >> seconds: secondCount nanoSeconds: nanoCount [ 
	self seconds: secondCount.
	self setMilliseconds: nanoCount//1000000

]

{ #category : #serialization }
PjTime >> serializationContents [
	^self
]

{ #category : #private }
PjTime >> ticks: anArray [
	"ticks is an Array: { days. seconds. nanoSeconds }"
	self seconds: (anArray at: 2) nanoSeconds: anArray last
]

{ #category : #accessing }
PjTime >> year [
	^self getFullYear
]
