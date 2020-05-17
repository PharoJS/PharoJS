Class {
	#name : #PjAsJsObjectInJs,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsCoreLibrariesTest-Objects'
}

{ #category : #tests }
PjAsJsObjectInJs >> testBoolean [
	self assertBlock: [ true asJsObject == true].
	self assertBlock: [ false asJsObject == false].

]

{ #category : #tests }
PjAsJsObjectInJs >> testConvertingADictionary [
	self assertBlock: [{ #a -> 1. #b -> 2. #c -> 3 } asDictionary asJsObject class == Object].

]

{ #category : #tests }
PjAsJsObjectInJs >> testConvertingAnAssociationArray [
	self assertBlock: [{ #a -> 1. #b -> 2. #c -> 3 } asJsObject class == Object].

]

{ #category : #tests }
PjAsJsObjectInJs >> testConvertingCompositeArray [
	| converted convertedAssociations convertedDict |
	converted := self evalBlock: [
		{ 
		#array -> #(1 2 3). 
		#associationArray -> { #a -> 1. #b -> 2. #c -> 3 }.
		#dict ->  { #x -> 0. #y -> 3.14.} asDictionary.
		#object -> Object new
	} asJsObject].
	self assertBlock: [converted class == Object].
	self assertBlock: [(converted at: #array) class == Array].
	self assertBlock: [(converted at: #object) class == Object].
	convertedAssociations := converted at: #associationArray.
	self assertBlock: [convertedAssociations class == Object].
	#(a b c) with: #(1 2 3) do: [ : iv : expectedValue | 
		self assert: (convertedAssociations at: iv) equals: expectedValue].
	convertedDict := converted at: #dict.
	self assertBlock: [convertedDict class == Object].
	#(x y) with: #(0 3.14) do: [ : iv : expectedValue | 
		self assert: (convertedDict at: iv) equals: expectedValue].
		
]

{ #category : #tests }
PjAsJsObjectInJs >> testConvertingCompositeDictionary [
	| converted |
	converted := self evalBlock: [
		{ 
		#array -> #(1 2 3). 
		#associationArray -> { #a -> 1. #b -> 2. #c -> 3 }.
		#dict ->  { #x -> 0. #y -> 3.14.} asDictionary.
		#object -> Object new
	} asDictionary asJsObject].
	self assertBlock: [converted class == Object].
	self assertBlock: [(converted at: #array) class == Array].
	self assertBlock: [(converted at: #object) class == Object].
	self assertBlock: [(converted at: #associationArray) class == Object].
	self assertBlock: [(converted at: #dict) class == Object].

]

{ #category : #tests }
PjAsJsObjectInJs >> testConvertingObjectWithNestedDictionaryAndArray [
	| original converted |
	original :=  self evalBlock: [PjObjectForTestingAsJsObject from:
		{ 
		#plainArray -> #(1 2 3). 
		#associationArray -> { #a -> 1. #b -> 2. #c -> 3 }.
		#dict ->  { #x -> 0. #y -> 3.14.} asDictionary.
		#object -> Object new
	}].
	converted := self evalBlock: [original asJsObject].
	self assertBlock: [converted == original].
	self assertBlock: [converted class == PjObjectForTestingAsJsObject].
	self assertBlock: [converted plainArray == original plainArray].
	self assertBlock: [converted plainArray class == Array].
	self assertBlock: [converted associationArray == original associationArray].
	self assertBlock: [converted associationArray class == Array].
	self assertBlock: [converted dict == original dict].
	self assertBlock: [converted dict class == Dictionary].
	self assertBlock: [converted object == original object].
	self assertBlock: [converted object class == Object].

]

{ #category : #tests }
PjAsJsObjectInJs >> testIfnil [
    self
        assertBlock: [ PjDummyTestObject string: ('Hello' ifNil: [ 'World' ]).
            PjDummyTestObject string = 'Hello' ]
]

{ #category : #tests }
PjAsJsObjectInJs >> testIgnoreArrayOfNonAssociations [
	self assertBlock: [#(1 2 3) asJsObject class == Array].

]

{ #category : #tests }
PjAsJsObjectInJs >> testNumber [
	self assertBlock: [ 3.14 asJsObject == 3.14].
	self assertBlock: [ 42 asJsObject == 42].

]

{ #category : #tests }
PjAsJsObjectInJs >> testString [
	self assertBlock: [ 'Smalltalk Rocks!' asJsObject == 'Smalltalk Rocks!'].

]
