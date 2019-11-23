Trait {
	#name : #PjTDateAndTime,
	#traits : 'PjTDate',
	#classTraits : 'PjTDate classTrait',
	#category : #'PharoJsCoreLibraries-Chronology'
}

{ #category : #'pharoJs support' }
PjTDateAndTime classSide >> javascriptName [
	<pharoJsSkip>
	^ #Date
]

{ #category : #'instance creation' }
PjTDateAndTime classSide >> now [
	<javascript: 'return new this()'>
]

{ #category : #converting }
PjTDateAndTime >> asDateAndTime [
	^self
]

{ #category : #accessing }
PjTDateAndTime >> dayOfMonth [
	^self getDate
]

{ #category : #accessing }
PjTDateAndTime >> dayOfWeek [
	^self getDay + 1
]

{ #category : #accessing }
PjTDateAndTime >> hour [
	^self hour24

]

{ #category : #accessing }
PjTDateAndTime >> hour12 [
	| hour24 |
	hour24 := self hour24.
	hour24 = 0 ifTrue: [ ^12 ].
	hour24 > 12 ifTrue: [ ^hour24 - 12 ].
	^hour24
]

{ #category : #accessing }
PjTDateAndTime >> hour24 [
	^self getHours
]

{ #category : #accessing }
PjTDateAndTime >> milliSecond [
	^self getMilliseconds
]

{ #category : #accessing }
PjTDateAndTime >> minute [
	^self getMinutes
]

{ #category : #accessing }
PjTDateAndTime >> monthIndex [
	^self getMonth + 1
]

{ #category : #accessing }
PjTDateAndTime >> monthIndex: anInteger [
	^self month: anInteger - 1
]

{ #category : #accessing }
PjTDateAndTime >> second [
	^self getSeconds
]

{ #category : #accessing }
PjTDateAndTime >> year [
	^self getFullYear
]
