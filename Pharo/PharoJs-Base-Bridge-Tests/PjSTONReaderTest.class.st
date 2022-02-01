Class {
	#name : #PjSTONReaderTest,
	#superclass : #TestCase,
	#category : #'PharoJs-Base-Bridge-Tests-Tests'
}

{ #category : #private }
PjSTONReaderTest >> materialize: string [
	^ PjSTONReader from: string
]

{ #category : #tests }
PjSTONReaderTest >> testInfinity [
	self assert: (self materialize: 'Infinity') equals: Float infinity
]

{ #category : #tests }
PjSTONReaderTest >> testNaN [
	self assert: (self materialize: 'NaN') isNaN
]

{ #category : #tests }
PjSTONReaderTest >> testNegativeInfinity [
	self assert: (self materialize: '-Infinity') equals: Float infinity negated
]
