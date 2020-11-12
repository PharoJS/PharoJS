Extension { #name : #PjDictionary }

{ #category : #'*PharoJsSerialization' }
PjDictionary class >> phxJsonClassName [
	^ 'Dictionary'
]

{ #category : #'*PharoJsSerialization' }
PjDictionary >> writePhxJsonRepresentationOn: w [
	self asJsObject writePhxJsonRepresentationOn: w
]
