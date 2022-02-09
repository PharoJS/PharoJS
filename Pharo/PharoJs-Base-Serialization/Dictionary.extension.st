Extension { #name : #Dictionary }

{ #category : #'*PharoJs-Base-Serialization' }
Dictionary class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| newDict |
	newDict := self new.
	reader addKnownObject: newDict.
	jsonObject keysAndValuesDo: [ :key :value | 
		newDict at: key put: (reader readFromJsObjectOrDictionary: value) ].
	^ newDict
]

{ #category : #'*PharoJs-Base-Serialization' }
Dictionary >> writePhxJsonRepresentationOn: w [
	w
		doBetweenCurlyBraces: [ self keys
				do:
					[ :key | w writeKeyName: key andValue: [ (self at: key) writePhxJsonOn: w ] ]
				separatedBy: [ w comma ] ]
]
