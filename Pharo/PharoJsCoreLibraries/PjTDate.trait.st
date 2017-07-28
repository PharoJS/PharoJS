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

{ #category : #serialization }
PjTDate classSide >> newFromMaterialized: jsonString [
	<javascript: 'return new Date(jsonString)'>
	
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

{ #category : #serialization }
PjTDate >> serializationContents [
	^self
]

{ #category : #accessing }
PjTDate >> year [
	^self getFullYear
]
