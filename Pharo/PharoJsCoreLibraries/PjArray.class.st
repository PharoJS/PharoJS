"
I represent the Javascript Array type.  I am the implementation for Arrays and OrderedCollections, since Javascript Arrays act pretty-much like Smalltalk OrderedCollections.
"
Class {
	#name : #PjArray,
	#superclass : #PjObject,
	#traits : 'PjTArray + PjTExtensionClass',
	#classTraits : 'PjTArray classTrait + PjTExtensionClass classTrait',
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'instance creation' }
PjArray class >> new: ignored [
	^ self new
]

{ #category : #'instance creation' }
PjArray class >> streamContents: aBlock [
	| stream |
	stream := PjArrayStream new.
	aBlock value: stream.
	^ stream contents
]

{ #category : #'instance creation' }
PjArray class >> with: anObject [ 
	"Answer a new instance of me, containing only anObject."
	<javascript: 'return [anObject]'>
]

{ #category : #'instance creation' }
PjArray class >> with: firstObject with: secondObject [ 
	"Answer a new instance of me, containing firstObject and secondObject."
	<javascript: 'return [firstObject,secondObject]'>
]

{ #category : #enumerating }
PjArray >> add: x [
	^ self addLast: x
]

{ #category : #enumerating }
PjArray >> addFirst: x [
	<javascript: 'this.unshift(x);return x'>
]

{ #category : #enumerating }
PjArray >> addLast: x [
	<javascript: 'this.push(x);return x'>
]

{ #category : #accessing }
PjArray >> anyOne [
	<javascript: 'return this[0]'>
]

{ #category : #enumerating }
PjArray >> at: i put: x [
	<javascript: 'return this[i-1]=x'>
]

{ #category : #accessing }
PjArray >> readStream [
	^ PjArrayStream on: self
]

{ #category : #removing }
PjArray >> remove: oldObject ifAbsent: absentBlock [
	| index |
	index := self findIndex: [ : each | oldObject = each ].
	index >= 0 ifTrue: [ ^ self removeAt: index + 1].
	^ absentBlock value
]

{ #category : #removing }
PjArray >> removeAll [
	self size timesRepeat: [ self removeFirst ]
]

{ #category : #removing }
PjArray >> removeAt: aNumber [
	<javascript: 'var result=this[aNumber-1];this.splice(aNumber - 1,1);return result'>

]

{ #category : #removing }
PjArray >> removeFirst [
	<javascript: 'return this.shift()'>
]

{ #category : #removing }
PjArray >> removeLast [
	<javascript: 'return this.pop()'>
]

{ #category : #accessing }
PjArray >> replaceFrom: start to: stop with: replacement startingAt: repStart [
	<javascript: '
	for(var mine=stop-1,other=mine+repStart-start;
		mine>=start-1;
		--other,--mine
		)this[mine]=replacement[other];return this'>
]

{ #category : #accessing }
PjArray >> writeStream [
	^ PjArrayStream new
]
