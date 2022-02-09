Class {
	#name : #PjAsJsObjectInPharo,
	#superclass : #TestCase,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #tests }
PjAsJsObjectInPharo >> testBasicObjects [
	{ 'abc'. true. false. nil. 3.14. 2000. $a } do: [ : each |
		self assert: each asJsObject == each
	]
]

{ #category : #tests }
PjAsJsObjectInPharo >> testConvertingADictionary [
	| dict |
	dict := { #a -> 1. #b -> 2. #c -> 3 } asDictionary.
	self assert: (dict asJsObject isKindOf: Dictionary)
]

{ #category : #tests }
PjAsJsObjectInPharo >> testConvertingAnAssociationArray [
	| converted |
	converted := { #a -> 1. #b -> 2. #c -> 3 } asJsObject.
	self assert: (converted isKindOf: Dictionary)
]

{ #category : #tests }
PjAsJsObjectInPharo >> testConvertingCompositeArray [
	| converted |
	converted := { 
		#array -> #(1 2 3). 
		#associationArray -> { #a -> 1. #b -> 2. #c -> 3 }.
		#dict ->  { #x -> 0. #y -> 3.14.} asDictionary.
		#object -> Object new
	} asJsObject.
	self assert: (converted isKindOf: Dictionary).
	self assert: ((converted at: #array) isKindOf: Array).
	self assert: ((converted at: #object) isKindOf: Dictionary).
	self assert: ((converted at: #associationArray) isKindOf: Dictionary).
	self assert: ((converted at: #dict) isKindOf: Dictionary).
]

{ #category : #tests }
PjAsJsObjectInPharo >> testConvertingCompositeDictionary [
	| converted |
	converted := { 
		#array -> #(1 2 3). 
		#associationArray -> { #a -> 1. #b -> 2. #c -> 3 }.
		#dict ->  { #x -> 0. #y -> 3.14.} asDictionary.
		#object -> Object new
	} asDictionary asJsObject.
	self assert: (converted isKindOf: Dictionary).
	self assert: ((converted at: #array) isKindOf: Array).
	self assert: ((converted at: #object) isKindOf: Dictionary).
	self assert: ((converted at: #associationArray) isKindOf: Dictionary).
	self assert: ((converted at: #dict) isKindOf: Dictionary).
]

{ #category : #tests }
PjAsJsObjectInPharo >> testConvertingObjectWithNestedDictionaryAndArray [
	| original converted |
	original := PjObjectForTestingAsJsObject from: { 
		#plainArray -> #(1 2 3). 
		#associationArray -> { #a -> 1. #b -> 2. #c -> 3 }.
		#dict ->  { #x -> 0. #y -> 3.14.} asDictionary.
		#objectNoIvs -> Object new.
		#objectWithIvs -> (PjObjectForTestingAsJsObject from: {#plainArray -> #(x y z)}).
	}.
	converted := original asJsObject.
	self assert: (converted isKindOf: Dictionary).
	self assert: ((converted at: #plainArray) isKindOf: Array).
	self assert: ((converted at: #objectNoIvs) isKindOf: Dictionary).
	self assert: ((converted at: #objectWithIvs) isKindOf: Dictionary).
	self assert: ((converted at: #associationArray) isKindOf: Dictionary).
	self assert: ((converted at: #dict) isKindOf: Dictionary).
]

{ #category : #tests }
PjAsJsObjectInPharo >> testIgnoreArrayOfNonAssociations [
	| array |
	array := #(1 2 3).
	self assert: array asJsObject == array
]

{ #category : #tests }
PjAsJsObjectInPharo >> testProxy [
	| proxy |
	proxy := PjProxy new.
	self assert: proxy asJsObject == proxy
]
