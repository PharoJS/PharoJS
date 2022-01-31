"
I am a log event subclassed from ZnLogEvent that is used to log webSocket I/O

I am usually used at an extended loglevel of 4
"
Class {
	#name : #PjSocketLogEvent,
	#superclass : #ZnServerLogEvent,
	#instVars : [
		'direction',
		'contents'
	],
	#category : #'PharoJsBridge-Kernel'
}

{ #category : #accessing }
PjSocketLogEvent >> contents: anObject [
	contents := anObject
]

{ #category : #accessing }
PjSocketLogEvent >> direction: anObject [
	direction := anObject
]

{ #category : #printing }
PjSocketLogEvent >> printContentsOn: stream [
	| limitedString |
	limitedString := String streamContents: [: s | s nextPutAll: contents ] limitedTo: 20.
	stream
		nextPutAll: ' socket ';
		nextPutAll: direction asString;
		nextPut: $:;
		space;
		nextPutAll: limitedString.
	limitedString size < contents size ifTrue: [
		stream
			nextPutAll: '... ';
			print: contents size;
			nextPut: $B].
]
