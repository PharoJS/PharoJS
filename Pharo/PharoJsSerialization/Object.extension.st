Extension { #name : #Object }

{ #category : #'*PharoJsSerialization' }
Object >> allPhxJsonInstvarNames [
	^ self class allInstVarNames
]

{ #category : #'*PharoJsSerialization' }
Object >> asPhxJsonString [
	| writer |
	writer := self class newPhxJsonWriter.
	self writePhxJsonOn: writer.
	^ writer string
]

{ #category : #'*PharoJsSerialization' }
Object class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| obj |
	obj := self new.
	reader addKnownObject: obj.
	jsonObject
		keysAndValuesDo: [ :k :v | obj instVarNamed: k put: (reader readFromJsObjectOrDictionary: v) ].
	^ obj 
]

{ #category : #'*PharoJsSerialization' }
Object class >> newPhxJsonWriter [
	^PhxJsonWriter new
]

{ #category : #'*PharoJsSerialization' }
Object class >> phxJsonClassName [
	^ self name
]

{ #category : #'*PharoJsSerialization' }
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

{ #category : #'*PharoJsSerialization' }
Object >> writePhxJsonOn: w [
	w
		writeReferenceFor: self
		or: [ self writePhxJsonObjectOn: w ]
]

{ #category : #'*PharoJsSerialization' }
Object >> writePhxJsonRepresentationOn: w [
	w
		doBetweenCurlyBraces: [ self allPhxJsonInstvarNames
				do: [ :key | 
					w
						writeKeyName: key
						andValue: [ (self instVarNamed: key) writePhxJsonOn: w ] ]
				separatedBy: [ w comma ] ]
]
