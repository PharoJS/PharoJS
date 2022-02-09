Extension { #name : #PjDictionary }

{ #category : #'*PharoJs-Base-Serialization' }
PjDictionary class >> phxJsonClassName [
	^ 'Dictionary'
]

{ #category : #'*PharoJs-Base-Serialization' }
PjDictionary >> writePhxJsonRepresentationOn: w [
	self asJsObject writePhxJsonRepresentationOn: w
]
