"
Duration representation
"
Class {
	#name : #PjDuration,
	#superclass : #PjMagnitude,
	#pools : [
		'ChronologyConstants'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Chronology'
}

{ #category : #'pharoJs support' }
PjDuration class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	| creationSelectors instanceSelectors |
	creationSelectors := Duration class 
		selectorsInProtocols: #('instance creation' 'instance creation simple' '*PharoExtra-Chronology')  
		exclude: #(readFrom: fromString: month:).
	instanceSelectors := Duration 
		selectorsInProtocols: #(accessing arithmetic comparing converting initialization private '*PharoExtra-Chronology')
		exclude: #(asDelay storeOn:). "asDelay exclued because no support for Delay yet!"
	^{Duration class -> creationSelectors.
	Duration -> instanceSelectors }
]

{ #category : #adding }
PjDuration >> addDateAndTime: aDateAndTime [
	^(DateAndTime 
		year: aDateAndTime year
		month: aDateAndTime monthIndex
		day: (aDateAndTime dayOfMonth + self days)
		hour: (aDateAndTime hour24 + self hoursCount) 
		minute: (aDateAndTime minute + self minutesCount)
		second: (aDateAndTime second + self secondsCount))
		setMilliseconds: (aDateAndTime getMilliseconds + self millisecondsCount);
		yourself
]

{ #category : #adding }
PjDuration >> printString [

	^ (self asNanoSeconds < 0
		   ifTrue: [ '-' ]
		   ifFalse: [ '+' ]) , (self printWithLeading0: self hoursCount)
	  , ':' , (self printWithLeading0: self minutesCount)
]

{ #category : #adding }
PjDuration >> printWithLeading0: aNumber [
"there must be nicer solution for that..."
	^ aNumber abs < 10
		  ifTrue: [ '0' , aNumber abs asString ]
		  ifFalse: [ aNumber abs asString ]
]
