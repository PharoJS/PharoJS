Class {
	#name : #PjDuration,
	#superclass : #PjMagnitude,
	#pools : [
		'ChronologyConstants'
	],
	#category : #'PharoJsCoreLibraries-Chronology'
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
	^DateAndTime 
		year: aDateAndTime year
		month: aDateAndTime monthIndex
		day: (aDateAndTime dayOfMonth + self days)
		hour: (aDateAndTime hour24 + self hoursCount) 
		minute: (aDateAndTime minute + self minutesCount)
		second: (aDateAndTime second + self secondsCount)

]
