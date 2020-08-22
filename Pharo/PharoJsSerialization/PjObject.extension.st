Extension { #name : #PjObject }

{ #category : #'*PharoJsSerialization' }
PjObject >> allPhxJsonInstvarNames [
	^ self keys
]

{ #category : #'*PharoJsSerialization' }
PjObject class >> instantiateWithPhxJsonReader: reader instanceJsonObject: jsonObject [
	| obj |
	obj := self new.
	reader addKnownObject: obj.
	jsonObject
		keysAndValuesDo: [ :k :v | obj instVarNamed: k put: (reader readFromJsObjectOrDictionary: v) ].
	^ obj 
]

{ #category : #'*PharoJsSerialization' }
PjObject class >> jsTranspilationImportMethodsNonstandard [
	<pharoJsSkip>
	^ {(Object class -> #(newPhxJsonWriter)).
	(Object
		->
			#(asPhxJsonString #writePhxJsonOn: writePhxJsonRepresentationOn: #writePhxJsonObjectOn:))}
]

{ #category : #'*PharoJsSerialization' }
PjObject class >> phxJsonClassName [
	^ self name
]
