Extension { #name : #PjObject }

{ #category : #'*PharoJs-Base-Serialization' }
PjObject >> allPhxJsonInstvarNames [
	^ self keys
]

{ #category : #'*PharoJs-Base-Serialization' }
PjObject class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| obj |
	obj := self new.
	reader addKnownObject: obj.
	jsonObject
		keysAndValuesDo: [ :k :v | obj instVarNamed: k put: (reader readFromJsObjectOrDictionary: v) ].
	^ obj
]

{ #category : #'*PharoJs-Base-Serialization' }
PjObject class >> jsTranspilationImportMethodsNonstandard [
	<pharoJsSkip>
	^ {(Object class -> #(newPhxJsonWriter)).
	(Object
		->
			#(asPhxJsonString #writePhxJsonOn: writePhxJsonRepresentationOn: #writePhxJsonObjectOn:))}
]

{ #category : #'*PharoJs-Base-Serialization' }
PjObject class >> phxJsonClassName [
	^ self name
]
