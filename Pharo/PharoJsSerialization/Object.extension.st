Extension { #name : #Object }

{ #category : #'*PharoJsSerialization' }
Object >> ivNamesAndValuesDo: aBlock [
	| ivValue |
	self class allInstVarNames do: [ : ivName |
		ivValue := self instVarNamed: ivName.
		aBlock value: ivName value: ivValue ]
]

{ #category : #'*PharoJsSerialization' }
Object >> jsonSerialize [
	^ PjSerializer serialize: self
]

{ #category : #'*PharoJsSerialization' }
Object >> jsonSerializeWith: aSerializer [
	aSerializer serializeObject: self

]

{ #category : #'*PharoJsSerialization' }
Object class >> newFromMaterialized: serializationDict [
	|restored|
	restored := self new. "Ensure initialize is performed in case there are new IVs"
	serializationDict keysAndValuesDo: [ : ivName :ivValue |
		restored 
			instVarNamed: ivName
			put: ivValue.
	].
	^restored

]

{ #category : #'*PharoJsSerialization' }
Object >> notNilIvNamesAndValuesDo: aBlock [
	| ivValue |
	self class allInstVarNames do: [ : ivName |
		ivValue := self instVarNamed: ivName.
		ivValue ifNotNil: [aBlock value: ivName value: ivValue] ]
]
