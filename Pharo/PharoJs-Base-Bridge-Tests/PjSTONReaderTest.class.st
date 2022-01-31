Class {
	#name : #PjSTONReaderTest,
	#superclass : #TestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #private }
PjSTONReaderTest >> materialize: string [
	^ PjSTONReader from: string
]

{ #category : #testing }
PjSTONReaderTest >> testInfinity [
	self assert: (self materialize: 'Infinity') equals: Float infinity
]

{ #category : #testing }
PjSTONReaderTest >> testNaN [
	self assert: (self materialize: 'NaN') isNaN
]

{ #category : #testing }
PjSTONReaderTest >> testNegInfinity [
	self assert: (self materialize: '-Infinity') equals: Float infinity negated
]
