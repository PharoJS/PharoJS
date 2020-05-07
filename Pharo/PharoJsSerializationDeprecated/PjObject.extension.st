Extension { #name : #PjObject }

{ #category : #'*PharoJsSerializationDeprecated' }
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

{ #category : #'*PharoJsSerializationDeprecated' }
PjObject >> serializationArray [
	^ {self className.
	self serializationContents}
]

{ #category : #'*PharoJsSerializationDeprecated' }
PjObject >> serializationContents [
	|serializable|
	serializable := OrderedCollection new.
	self keysAndValuesDo: [ : key : value |
		serializable add: key.
		serializable add: value serializationArray.
	].
	^serializable
]

{ #category : #'*PharoJsSerializationDeprecated' }
PjObject >> serialize [
	^ self serializationArray asJSON
]
