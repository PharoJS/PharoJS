Extension { #name : #Object }

{ #category : #'*PharoJs-Base-Serialization' }
Object >> allPhxJsonInstvarNames [
	^ self class allInstVarNames
]

{ #category : #'*PharoJs-Base-Serialization' }
Object >> asPhxJsonString [
	| writer |
	writer := self class newPhxJsonWriter.
	self writePhxJsonOn: writer.
	^ writer string
]

{ #category : #'*PharoJs-Base-Serialization' }
Object class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| obj |
	obj := self new.
	reader addKnownObject: obj.
	jsonObject
		keysAndValuesDo: [ :k :v | obj instVarNamed: k put: (reader readFromJsObjectOrDictionary: v) ].
	^ obj
]

{ #category : #'*PharoJs-Base-Serialization' }
Object class >> newPhxJsonWriter [
	^PhxJsonWriter new
]

{ #category : #'*PharoJs-Base-Serialization' }
Object class >> phxJsonClassName [
	^ self name
]

{ #category : #'*PharoJs-Base-Serialization' }
Object >> writePhxJsonObjectOn: w [
	^ w
		doBetweenCurlyBraces: [ w writeKeyName: 'class' andValue: self class phxJsonClassName.
			w comma.
			"usefull for debugging: 
			w writeKeyName: 'instId' andValue: (w identityIndexOf: self).
			w comma."
			w
				writeKeyName: 'instance'
				andValue: [ self writePhxJsonRepresentationOn: w ] ]
]

{ #category : #'*PharoJs-Base-Serialization' }
Object >> writePhxJsonOn: w [
	w
		writeReferenceFor: self
		or: [ self writePhxJsonObjectOn: w ]
]

{ #category : #'*PharoJs-Base-Serialization' }
Object >> writePhxJsonRepresentationOn: w [
	w
		doBetweenCurlyBraces: [ self allPhxJsonInstvarNames
				do: [ :key | 
					w
						writeKeyName: key
						andValue: [ (self instVarNamed: key) writePhxJsonOn: w ] ]
				separatedBy: [ w comma ] ]
]
