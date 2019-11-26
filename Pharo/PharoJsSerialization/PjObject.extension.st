Extension { #name : #PjObject }

{ #category : #'*PharoJsSerialization' }
PjObject >> initAfterMaterializationWith: materializedObjects [
	self keysAndValuesDo: [ : key : value | ]
]

{ #category : #'*PharoJsSerialization' }
PjObject >> notNilIvNamesAndValuesDo: aBlock [
	self keysAndValuesDo: aBlock
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
