Extension { #name : #PjIdentityDictionary }

{ #category : #'*PharoJs-Base-Serialization' }
PjIdentityDictionary class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| obj |
	obj := self new.
	reader addKnownObject: obj.
	jsonObject
		keysAndValuesDo: [ :k :v | obj at: k put: (reader readFromJsObjectOrDictionary: v) ].
	^ obj 
]

{ #category : #'*PharoJs-Base-Serialization' }
PjIdentityDictionary class >> phxJsonClassName [
	^ 'IdentityDictionary'
]
