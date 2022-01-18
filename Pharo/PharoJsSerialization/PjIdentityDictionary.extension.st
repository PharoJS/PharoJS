Extension { #name : #PjIdentityDictionary }

{ #category : #'*PharoJsSerialization' }
PjIdentityDictionary class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| obj |
	obj := self new.
	reader addKnownObject: obj.
	jsonObject
		keysAndValuesDo: [ :k :v | obj at: k put: (reader readFromJsObjectOrDictionary: v) ].
	^ obj 
]

{ #category : #'*PharoJsSerialization' }
PjIdentityDictionary class >> phxJsonClassName [
	^ 'IdentityDictionary'
]
