"
I gather methods shared by extensions to JS Date (PjTime, PjDate, PjDateAndTime)
"
Trait {
	#name : #PjTDate,
	#category : #'PharoJs-Base-JS-CoreLibraries-Chronology'
}

{ #category : #'instance creation' }
PjTDate classSide >> basicNew [
	"To support sending the initialize message even from plain JS using the new operator 
	PjFunction class >> basicNew sends an argument to the JS constructor. 
	This breaks date creation. Hence the redefinition."

	" More in `PjTranspiler>>#writeInitializeSupportFor: aClass`"

	<javascript: 'return new this()'>
	
]

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
PjTDate >> year [
	^self getFullYear
]
