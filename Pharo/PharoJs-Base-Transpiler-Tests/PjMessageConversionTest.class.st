Class {
	#name : #PjMessageConversionTest,
	#superclass : #TestCase,
	#instVars : [
		'converter'
	],
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #tests }
PjMessageConversionTest >> addSome [
	converter addAllConversions: (#(2 6 4) collect: [ : i | PjNullMessageConversionForTest new order: i selector: #foo]).
	converter addAllConversions: (#(8 4) collect: [ : i | PjNullMessageConversionForTest new order: i selector: #bar])
]

{ #category : #tests }
PjMessageConversionTest >> convert: selector receiver: aLiteral args: args [
	| receiverAstNode |
	receiverAstNode := RBLiteralNode value: aLiteral.
	^converter convert: selector receiver: receiverAstNode args: args
]

{ #category : #tests }
PjMessageConversionTest >> setUp [
	super setUp.
	converter := PjMessageConverter new.
]

{ #category : #tests }
PjMessageConversionTest >> testAdd [
	self addSome.
	self assert: (self convert: #bar receiver: 5 args: #()) equals: 8.
	converter addConversion: (PjNullMessageConversionForTest new order: 6 selector: #bar).
	self assert: (self convert: #bar receiver: 5 args: #()) equals: 6
]

{ #category : #tests }
PjMessageConversionTest >> testEmpty [
	self assert: (self convert: #foo receiver: nil args: #()) equals: nil
]

{ #category : #tests }
PjMessageConversionTest >> testRemove [
	self addSome.
	self assert: (self convert: #foo receiver: 3 args: #()) equals: 4.
	converter removeConversion: (PjNullMessageConversionForTest new order: 4 selector: #foo).
	self assert: (self convert: #foo receiver: 3 args: #()) equals: 6.
	self assert: (self convert: #foo receiver: 1 args: #()) equals: 2.
	converter removeConversion: (PjNullMessageConversionForTest new order: 6 selector: #foo).
	self assert: (self convert: #foo receiver: 3 args: #()) equals: nil
]

{ #category : #tests }
PjMessageConversionTest >> testSome [
	self addSome.
	self assert: (self convert: #foo receiver: 3 args: #()) equals: 4.
	self assert: (self convert: #foo receiver: 5 args: #()) equals: 6.
	self assert: (self convert: #foo receiver: 1 args: #()) equals: 2.
	self assert: (self convert: #foo receiver: 6 args: #()) equals: nil.
	self assert: (self convert: #bar receiver: 3 args: #()) equals: 4.
	self assert: (self convert: #bar receiver: 5 args: #()) equals: 8.
	self assert: (self convert: #bar receiver: 1 args: #()) equals: 4.
	self assert: (self convert: #foo receiver: 9 args: #()) equals: nil
]
