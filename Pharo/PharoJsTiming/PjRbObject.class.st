Class {
	#name : #PjRbObject,
	#superclass : #Object,
	#classVars : [
		'DeviceA',
		'DeviceB',
		'DevicePacketKind',
		'HandlerA',
		'HandlerB',
		'Idler',
		'WorkPacketKind',
		'Worker'
	],
	#category : #'PharoJsTiming-Richards'
}

{ #category : #initialize }
PjRbObject class >> initialize [
    "RBObject initialize"
    DeviceA := 5.
    DeviceB := 6.
    DevicePacketKind := 1.
    HandlerA := 3.
    HandlerB := 4.
    Idler := 1.
    Worker := 2.
    WorkPacketKind := 2
]

{ #category : #utilities }
PjRbObject >> append: packet head: queueHead [
    | mouse link |
    packet link: nil.
    queueHead isNil ifTrue: [^packet].
    mouse := queueHead.
    [(link := mouse link) isNil]
	whileFalse: [mouse := link].
    mouse link: packet.
    ^queueHead
]

{ #category : #transcript }
PjRbObject >> cr [
	<javascript: ''>
	Transcript cr
]

{ #category : #transcript }
PjRbObject >> show: aString [
	<javascript: 'console.log(aString._asString())'>
	Transcript show: aString
]
