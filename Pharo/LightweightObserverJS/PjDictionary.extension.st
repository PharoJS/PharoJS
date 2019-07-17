Extension { #name : #PjDictionary }

{ #category : #'*LightweightObserverJS' }
PjDictionary >> asSubject [
	LoSubjectDictionary adoptInstance: self
]
