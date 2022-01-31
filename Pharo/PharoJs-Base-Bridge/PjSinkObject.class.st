"
A PjSinkObject is an object that accepts any message. The response is always itself. This is usefull as a placeholder of missing objects, such as javascript globals. It allows partially testing code that relies on Javascript libraries. 

"
Class {
	#name : #PjSinkObject,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : #'PharoJs-Base-Bridge-Proxy'
}

{ #category : #'default instance' }
PjSinkObject class >> default [
	^default ifNil: [ default := self new ]
]

{ #category : #'reflective operations' }
PjSinkObject class >> doesNotUnderstand: aMessage [
	^self
]

{ #category : #'default instance' }
PjSinkObject class >> resetDefault [
	"self resetDefault"
	default := nil
]

{ #category : #'reflective operations' }
PjSinkObject >> doesNotUnderstand: aMessage [
	^self
]
