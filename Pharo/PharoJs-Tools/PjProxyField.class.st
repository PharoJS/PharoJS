Class {
	#name : #PjProxyField,
	#superclass : #Association,
	#instVars : [
		'proxy'
	],
	#category : #'PharoJs-Tools-Inspector'
}

{ #category : #creating }
PjProxyField class >> proxy: aPjProxy key: aString [
	^ self new
		proxy: aPjProxy key: aString;
		yourself
]

{ #category : #initialization }
PjProxyField >> proxy: aPjProxy key: aString [
	proxy := aPjProxy.
	key := aString.
	value := self
]

{ #category : #accessing }
PjProxyField >> value [
	value == self ifFalse: [ ^ value ].
	value := proxy gefFieldValueFor: key.
	proxy := nil.
	^ value
]
