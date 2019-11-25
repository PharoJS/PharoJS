Extension { #name : #PjObject }

{ #category : #'*PharoJsSerialization' }
PjObject >> initAfterMaterializationWith: materializedObjects [
	self keysAndValuesDo: [ : key : value | ]
]

{ #category : #'*PharoJsSerialization' }
PjObject >> jsonSerializeWith: aSerializer [
	aSerializer serializeObject: self

]

{ #category : #'*PharoJsSerialization' }
PjObject class >> newFromMaterialized: serializationArray [
	|restored ivIndex|
	restored := self new. "Ensure initialize is performed in case there are new IVs"
	ivIndex := 1.
	[ivIndex <= serializationArray size] whileTrue: [
		restored 
			instVarNamed: (serializationArray at: ivIndex) 
			put: (serializationArray at: ivIndex + 1) materialize.
		ivIndex := ivIndex + 2.
	].
	^restored

]

{ #category : #'*PharoJsSerialization' }
PjObject >> serializationArray [
	^ {self className.
	self serializationContents}
]

{ #category : #'*PharoJsSerialization' }
PjObject >> serializationContents [
	|serializable|
	serializable := OrderedCollection new.
	self keysAndValuesDo: [ : key : value |
		serializable add: key.
		serializable add: value serializationArray.
	].
	^serializable
]

{ #category : #'*PharoJsSerialization' }
PjObject >> serialize [
	^ PjSerializer serialize: self
]

{ #category : #'*PharoJsSerialization' }
PjObject >> serializeOLD [
	^ self serializationArray asJSON
]
