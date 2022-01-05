Extension { #name : #DateAndTime }

{ #category : #'*PharoJsCoreLibraries' }
DateAndTime >> getTime [

	" answer number of milliseconds since unix epoch (midnight Jan 1, 1970, UTC)
	 - for compatibility with Javascript "

	^ self asUnixTime * 1000
]

{ #category : #'*PharoJsCoreLibraries-Chronology' }
DateAndTime class >> javascriptPlaceholder [
	<pharoJsSkip>
	^PjDateAndTime
]
