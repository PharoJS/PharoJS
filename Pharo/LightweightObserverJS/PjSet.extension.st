Extension { #name : #PjSet }

{ #category : #'*LightweightObserverJS' }
PjSet >> asSubject [
	LoSubjectSet adoptInstance: self
]
