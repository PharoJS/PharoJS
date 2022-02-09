"
I represent the Javascript Error type.
"
Class {
	#name : #PjError,
	#superclass : #PjObject,
	#traits : 'PjTExtensionClass',
	#classTraits : 'PjTExtensionClass classTrait',
	#instVars : [
		'message'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'initialization-release' }
PjError class >> javascriptInitialize [
	self instVarNamed: #stackTraceLimit put: 100
]

{ #category : #'pharoJs support' }
PjError class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ { (Exception -> #( defaultDescription description )) }
]

{ #category : #'instance creation' }
PjError class >> signal [
	^self new signal
]

{ #category : #'instance creation' }
PjError class >> signal: aString [
	^self new signal: aString
]

{ #category : #accessing }
PjError >> messageText [
	^ message
]

{ #category : #accessing }
PjError >> messageText: anObject [
	message := anObject
]

{ #category : #signaling }
PjError >> signal [
	<javascript: 'throw this'>
]

{ #category : #signaling }
PjError >> signal: aString [
	self messageText: aString.
	^self signal.
]
