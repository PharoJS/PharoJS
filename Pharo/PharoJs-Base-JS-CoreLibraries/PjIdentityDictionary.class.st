"
I am the Javascript embodiment of IdentityDictionary.
"
Class {
	#name : #PjIdentityDictionary,
	#superclass : #PjDictionary,
	#instVars : [
		'map'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'dictionary access' }
PjIdentityDictionary >> at: key [
		<javascript: 'return this.map.get(key)'>
]

{ #category : #'dictionary access' }
PjIdentityDictionary >> at: key ifAbsent: aBlock [
	| value |
	value := self at: key.
	value ifNil: [^aBlock value].
	^value
]

{ #category : #'dictionary access' }
PjIdentityDictionary >> at: key ifAbsentPut: aBlock [
	^ self at: key ifAbsent: [ self at: key put: aBlock value ]
]

{ #category : #'dictionary access' }
PjIdentityDictionary >> at: key ifPresent: aBlock [
	| value |
	value := self at: key.
	value ifNil: [^nil].
	^aBlock value
]

{ #category : #'dictionary access' }
PjIdentityDictionary >> at: key ifPresent: aBlock ifAbsent: anotherBlock [
	| value |
	value := self at: key.
	value ifNil: [^anotherBlock value].
	^aBlock value
]

{ #category : #'dictionary access' }
PjIdentityDictionary >> at: key put: value [
	<javascript: 'this.map.set(key,value); return value'>
]

{ #category : #'dictionary access' }
PjIdentityDictionary >> do: aBlock [
	self valuesDo: aBlock
]

{ #category : #'initialize-release' }
PjIdentityDictionary >> initialize [
	super initialize.
	map := self newMap
]

{ #category : #'dictionary access' }
PjIdentityDictionary >> isEmpty [
	^self size = 0
]

{ #category : #'dictionary access' }
PjIdentityDictionary >> keysAndValuesDo: twoArgsBlock [
	<javascript: 'let iterator = this.map.entries();
	let iteration = iterator.next();
	while(!iteration.done){
		twoArgsBlock.apply(this,iteration.value);
		iteration = iterator.next();
	}
	return this;
	'>
]

{ #category : #'initialize-release' }
PjIdentityDictionary >> newMap [
	<javascript: 'return new Map()'>
]

{ #category : #'dictionary access' }
PjIdentityDictionary >> size [
	<javascript: 'return this.map.size'>
]

{ #category : #'dictionary access' }
PjIdentityDictionary >> valuesDo: aBlock [
	self keysAndValuesDo: [ : key : value| aBlock value: value ]
]
