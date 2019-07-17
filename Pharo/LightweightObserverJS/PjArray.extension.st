Extension { #name : #PjArray }

{ #category : #'*LightweightObserverJS' }
PjArray >> asSubject [
	LoSubjectOrderedCollection adoptInstance: self
]
