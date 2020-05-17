"
I gather methods shared by extensions to JS Date (PjTime, PjDate, PjDateAndTime)
"
Trait {
	#name : #PjTDate,
	#category : #'PharoJsCoreLibraries-Chronology'
}

{ #category : #'pharoJs support' }
PjTDate classSide >> javascriptName [
	<pharoJsSkip>
	^ #Date
]

{ #category : #'instance creation' }
PjTDate classSide >> now [
	<javascript: 'return new this()'>
]

{ #category : #'instance creation' }
PjTDate classSide >> today [
	^self now
]

{ #category : #accessing }
PjTDate >> addDays: dayCount [
	<javascript: 'return new Date(this.valueOf()+86400000*dayCount)'>
]

{ #category : #converting }
PjTDate >> asDateAndTime [
	^self
]

{ #category : #accessing }
PjTDate >> dayOfMonth [
	^self getDate
]

{ #category : #accessing }
PjTDate >> dayOfWeek [
	^self getDay + 1
]

{ #category : #accessing }
PjTDate >> monthIndex [
	^self getMonth + 1
]

{ #category : #accessing }
PjTDate >> monthIndex: anInteger [
	^self month: anInteger - 1
]

{ #category : #accessing }
PjTDate >> monthName [
	^ #(January February March April May June July August September October November December) at: self monthIndex
]

{ #category : #accessing }
PjTDate >> year [
	^self getFullYear
]
