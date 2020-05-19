"
A PjParametrizableServerDelegate is a delegate for the server that simply stores a HTML page that is sent as a response to any client request.

Instance Variables
	html:		<String>

html
	- HTML page sent to clients

"
Class {
	#name : #PjParametrizableServerDelegate,
	#superclass : #Object,
	#instVars : [
		'html',
		'javascript',
		'css',
		'favicon',
		'fingerPrint'
	],
	#category : #'PharoJsBridge-Kernel'
}

{ #category : #'instance-creation' }
PjParametrizableServerDelegate class >> new [
	^ super new
		initialize;
		yourself
]

{ #category : #accessing }
PjParametrizableServerDelegate >> css [
	^ css
]

{ #category : #accessing }
PjParametrizableServerDelegate >> css: anObject [
	css := anObject
]

{ #category : #accessing }
PjParametrizableServerDelegate >> favicon [
	^ favicon
]

{ #category : #accessing }
PjParametrizableServerDelegate >> favicon: anObject [
	favicon := anObject
]

{ #category : #accessing }
PjParametrizableServerDelegate >> fingerPrint [
	^ fingerPrint
]

{ #category : #accessing }
PjParametrizableServerDelegate >> fingerPrint: anObject [
	fingerPrint := anObject
]

{ #category : #handling }
PjParametrizableServerDelegate >> handleRequest: request [
	| entity prefix |
	prefix := request uri isSlash
		ifTrue: [ 'index.html' ]
		ifFalse: [ request uri firstPathSegment ].
	('index.html' = prefix and: self html isEmptyOrNil not)
		ifTrue: [ entity := ZnEntity html: self html ].
	('index.js' = prefix and: self javascript isEmptyOrNil not)
		ifTrue: [ entity := ZnEntity javascript: self javascript ].
	('index.css' = prefix and: self css isEmptyOrNil not)
		ifTrue: [ entity := ZnEntity css: self css ].
	('favicon.ico' = prefix and: self favicon isEmptyOrNil not)
		ifTrue: [ entity := ZnEntity favicon: self favicon ].
	'serverFingerPrint' = prefix
		ifTrue: [ entity := ZnEntity html: self fingerPrint ].
	entity ifNotNil: [ ^ ZnResponse ok: entity ].
	^ ZnResponse notFound: request uri
]

{ #category : #accessing }
PjParametrizableServerDelegate >> html [
	^html
]

{ #category : #accessing }
PjParametrizableServerDelegate >> html: aString [
	html := aString
]

{ #category : #'initialize-release' }
PjParametrizableServerDelegate >> initialize [
	super initialize.
	fingerPrint := UUIDGenerator next asString
]

{ #category : #accessing }
PjParametrizableServerDelegate >> javascript [
	^ javascript
]

{ #category : #accessing }
PjParametrizableServerDelegate >> javascript: anObject [
	javascript := anObject
]
