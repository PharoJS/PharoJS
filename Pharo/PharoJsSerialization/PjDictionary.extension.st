Extension { #name : #PjDictionary }

{ #category : #'*PharoJsSerialization' }
PjDictionary class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| n |
	n :=  self new.
	jsonObject keysAndValuesDo: [:k :v | n at: k put: (reader readFromJsObjectOrDictionary: v)  ].
	^n
		
]

{ #category : #'*PharoJsSerialization' }
PjDictionary class >> phxJsonClassName [
	^ 'Dictionary'
]

{ #category : #'*PharoJsSerialization' }
PjDictionary >> writePhxJsonRepresentationOn: w [
	self asJsObject writePhxJsonRepresentationOn: w
]
