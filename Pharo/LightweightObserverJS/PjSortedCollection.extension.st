Extension { #name : #PjSortedCollection }

{ #category : #'*LightweightObserverJS' }
PjSortedCollection >> asSubject [
	LoSubjectSortedCollection adoptInstance: self
]
