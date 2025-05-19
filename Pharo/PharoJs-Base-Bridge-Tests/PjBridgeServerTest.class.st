Class {
	#name : 'PjBridgeServerTest',
	#superclass : 'TestCase',
	#category : 'PharoJs-Base-Bridge-Tests-Tests',
	#package : 'PharoJs-Base-Bridge-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PjBridgeServerTest >> assertPortNumber: anInteger [
	self assert: self portNumber equals: anInteger 
]

{ #category : 'tests' }
PjBridgeServerTest >> incrementPortNumber [
	PjBridgeServer incrementCurrentPortNumber 
]

{ #category : 'tests' }
PjBridgeServerTest >> minPortNumber [
	^PjBridgeServer minPortNumber 
]

{ #category : 'tests' }
PjBridgeServerTest >> portNumber [
	^PjBridgeServer currentPortNumber
]

{ #category : 'tests' }
PjBridgeServerTest >> portNumber: anInteger [
	PjBridgeServer currentPortNumber: anInteger
]

{ #category : 'tests' }
PjBridgeServerTest >> testIncrementForbiddenPortNumber [

	self portNumber: 1718.
	self incrementPortNumber.
	self assertPortNumber: 1724
	
]

{ #category : 'tests' }
PjBridgeServerTest >> testIncrementMaxPortNumber [

	self portNumber: PjBridgeServer maxPortNumber.
	self incrementPortNumber.
	self assertPortNumber: self minPortNumber
	 
	
]

{ #category : 'tests' }
PjBridgeServerTest >> testIncrementMinPortNumber [

	self portNumber: self minPortNumber.
	self incrementPortNumber.
	self assertPortNumber: self minPortNumber + 1
	 
	
]

{ #category : 'tests' }
PjBridgeServerTest >> testMaxPortNumber [
	| max |
	max := PjBridgeServer maxPortNumber.
	self portNumber: max.
	self assertPortNumber: max.
	self portNumber: max + 1.
	self assertPortNumber: self minPortNumber 
	
]

{ #category : 'tests' }
PjBridgeServerTest >> testMinPortNumber [
	(-100 to: self minPortNumber - 1) do: [ : providedPortNumber | 
		self portNumber: providedPortNumber.
		self assertPortNumber: self minPortNumber
	] 
	
]

{ #category : 'tests' }
PjBridgeServerTest >> testResetPortNumberNotNil [
	PjBridgeServer resetPortNumber.
	self assertPortNumber: self minPortNumber 
	
]
