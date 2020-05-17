Class {
	#name : #PjMessageConversionTest,
	#superclass : #TestCase,
	#instVars : [
		'converter'
	],
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #running }
PjMessageConversionTest >> addSome [
	converter addAllConversions: (#(2 6 4) collect: [ : i | PjNullMessageConversionForTest new order: i selector: #foo]).
	converter addAllConversions: (#(8 4) collect: [ : i | PjNullMessageConversionForTest new order: i selector: #bar])
]

{ #category : #running }
PjMessageConversionTest >> setUp [
	super setUp.
	converter := PjMessageConverter new.
	
]

{ #category : #testing }
PjMessageConversionTest >> testAdd [
	self addSome.
	self assert: (converter convert: #bar receiver: 5 args: #()) equals: 8.
	converter addConversion: (PjNullMessageConversionForTest new order: 6 selector: #bar).
	self assert: (converter convert: #bar receiver: 5 args: #()) equals: 6
]

{ #category : #testing }
PjMessageConversionTest >> testEmpty [
	self assert: (converter convert: #foo receiver: nil args: #()) equals: nil
]

{ #category : #testing }
PjMessageConversionTest >> testRemove [
	self addSome.
	self assert: (converter convert: #foo receiver: 3 args: #()) equals: 4.
	converter removeConversion: (PjNullMessageConversionForTest new order: 4 selector: #foo).
	self assert: (converter convert: #foo receiver: 3 args: #()) equals: 6.
	self assert: (converter convert: #foo receiver: 1 args: #()) equals: 2.
	converter removeConversion: (PjNullMessageConversionForTest new order: 6 selector: #foo).
	self assert: (converter convert: #foo receiver: 3 args: #()) equals: nil
]

{ #category : #testing }
PjMessageConversionTest >> testSome [
	self addSome.
	self assert: (converter convert: #foo receiver: 3 args: #()) equals: 4.
	self assert: (converter convert: #foo receiver: 5 args: #()) equals: 6.
	self assert: (converter convert: #foo receiver: 1 args: #()) equals: 2.
	self assert: (converter convert: #foo receiver: 6 args: #()) equals: nil.
	self assert: (converter convert: #bar receiver: 3 args: #()) equals: 4.
	self assert: (converter convert: #bar receiver: 5 args: #()) equals: 8.
	self assert: (converter convert: #bar receiver: 1 args: #()) equals: 4.
	self assert: (converter convert: #foo receiver: 9 args: #()) equals: nil
]
