"
I represent the Javascript Function type.  I am the implementation for CompiledMethod and BlockClosure.

All the instance creation category *should* be in PjClass instead, but is here so new etc. work on ordinary Javascript ""classes"".
"
Class {
	#name : #PjFunction,
	#superclass : #PjObject,
	#traits : 'PjTExtensionClass',
	#classTraits : 'PjTExtensionClass classTrait',
	#instVars : [
		'subclasses'
	],
	#pools : [
		'PjUniversalGlobals'
	],
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #setup }
PjFunction class >> forceSubclass: aFunction [
	aFunction js_at: #__proto__ put: (self js_at: #prototype)
]

{ #category : #'pharoJs support' }
PjFunction class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{
		Behavior -> #( inheritsFrom: ).
		BlockClosure -> #( isBlock ).
	}
]

{ #category : #exceptions }
PjFunction class >> on_do_jsGenerator [
	<pharoJsSkip>
	^'try{
		return this()
	}catch(ex){
		if(ex.', PjTranspiler selectorsPrefix, 'isKindOf_(exception)){return handlerAction(ex)}
		throw ex
	}'
]

{ #category : #exceptions }
PjFunction >> assert [

	self value ifFalse: [AssertionFailure signal: 'Assertion failed']

]

{ #category : #'instance creation' }
PjFunction >> basicNew [
" here so that ordinary Javascript 'classes' will respond to the message"
	<javascript: 'return new this()'>
]

{ #category : #'instance creation' }
PjFunction >> basicNew: arg [
" here so that ordinary Javascript 'classes' will respond to the message"
	<javascript: 'return new this(arg)'>
]

{ #category : #'instance creation' }
PjFunction >> basicNew: arg1 with: arg2 [
" here so that ordinary Javascript 'classes' will respond to the message"
	<javascript: 'return new this(arg1, arg2)'>
]

{ #category : #'instance creation' }
PjFunction >> basicNew: arg1 with: arg2 with: arg3 [
" here so that ordinary Javascript 'classes' will respond to the message"
	<javascript: 'return new this(arg1, arg2, arg3)'>
]

{ #category : #'instance creation' }
PjFunction >> basicNew: arg1 with: arg2 with: arg3 with: arg4 [
" here so that ordinary Javascript 'classes' will respond to the message"
	<javascript: 'return new this(arg1, arg2, arg3, arg4)'>
]

{ #category : #'instance creation' }
PjFunction >> basicNew: arg1 with: arg2 with: arg3 with: arg4 with: arg5 [
" here so that ordinary Javascript 'classes' will respond to the message"
	<javascript: 'return new this(arg1, arg2, arg3, arg4, arg5)'>
]

{ #category : #'Behavior: reflection' }
PjFunction >> canUnderstand: selector [
	| jsSelector |
	jsSelector := PjCore makePharoJsSelector: selector.
	^ (self prototype js_at: jsSelector) ifNil: [ false ] ifNotNil: [: selct | '__DNU' ~= (selct js_at: #name)]
]

{ #category : #evaluating }
PjFunction >> close [
	PjCore log: 'unoptimized close may not capture semantics'.
	^ self
]

{ #category : #evaluating }
PjFunction >> cull: arg [
	"In javascript a function always uses only required arguments"
	^self value: arg
]

{ #category : #evaluating }
PjFunction >> cull: arg1 cull: arg2 [
	"In javascript a function always uses only required arguments"
	^self value: arg1 value: arg2
]

{ #category : #evaluating }
PjFunction >> cull: arg1 cull: arg2 cull: arg3 [
	"In javascript a function always uses only required arguments"
	^self value: arg1 value: arg2 value: arg3
]

{ #category : #evaluating }
PjFunction >> cull: arg1 cull: arg2 cull: arg3 cul: arg4 [
	"In javascript a function always uses only required arguments"
	^self value: arg1 value: arg2 value: arg3 value: arg4
]

{ #category : #exceptions }
PjFunction >> ensure: aBlock [
	<javascript: '
	try{
		return this()
	}finally{aBlock()}'>
]

{ #category : #exceptions }
PjFunction >> ifCurtailed: curtailBlock [
	| result curtailed |
	curtailed := true.
	[
		result := self value.
		curtailed := false
	] ensure: [
		curtailed ifTrue: [ curtailBlock value ] ].
	^ result
]

{ #category : #'instance creation' }
PjFunction >> new [
	^self basicNew 
		initialize;
		yourself
]

{ #category : #'instance creation' }
PjFunction >> new: arg [
	^(self basicNew: arg)
		initialize;
		yourself
]

{ #category : #'instance creation' }
PjFunction >> new: arg1 with: arg2 [
	^(self basicNew: arg1 with: arg2)
		initialize;
		yourself
]

{ #category : #'instance creation' }
PjFunction >> new: arg1 with: arg2 with: arg3 [
	^(self basicNew: arg1 with: arg2 with: arg3)
		initialize;
		yourself
]

{ #category : #'instance creation' }
PjFunction >> new: arg1 with: arg2 with: arg3 with: arg4 [
	^(self basicNew: arg1 with: arg2 with: arg3 with: arg4)
		initialize;
		yourself
]

{ #category : #'instance creation' }
PjFunction >> new: arg1 with: arg2 with: arg3 with: arg4 with: arg5 [
	^(self basicNew: arg1 with: arg2 with: arg3 with: arg4 with: arg5)
		initialize;
		yourself
]

{ #category : #exceptions }
PjFunction >> on: exception do: handlerAction [
	<jsGenerator: #on_do_jsGenerator>
]

{ #category : #'Behavior: reflection' }
PjFunction >> superclass [
	self == Object ifTrue: [ ^nil ].
	^((self js_at: #prototype) js_at: #__proto__) class
]

{ #category : #evaluating }
PjFunction >> value [
	<javascript: 'return this();'>
]

{ #category : #evaluating }
PjFunction >> value: arg [
	<javascript: 'return this(arg);'>
]

{ #category : #evaluating }
PjFunction >> value: arg1 value: arg2 [
	<javascript: 'return this(arg1, arg2);'>
]

{ #category : #evaluating }
PjFunction >> value: arg1 value: arg2 value: arg3 [
	<javascript: 'return this(arg1, arg2, arg3);'>
]

{ #category : #evaluating }
PjFunction >> value: arg1 value: arg2 value: arg3 value: arg4 [
	<javascript: 'return this(arg1, arg2, arg3, arg4);'>
]

{ #category : #evaluating }
PjFunction >> valueWithArguments: anArray [
	<javascript: 'return this.apply(this,anArray)'>
]

{ #category : #evaluating }
PjFunction >> valueWithEnoughArguments: anArray [
	"call me with enough arguments from anArray"
	"In javascript a function always uses only required arguments"
	<javascript: 'return this.apply(this,anArray)'>
]

{ #category : #looping }
PjFunction >> whileFalse [
	self whileFalse: []
]

{ #category : #looping }
PjFunction >> whileFalse: loopBlock [
	<javascript: 'while(false==this()){loopBlock();}'>
]

{ #category : #looping }
PjFunction >> whileTrue [
	self whileTrue: []
]

{ #category : #looping }
PjFunction >> whileTrue: loopBlock [
	<javascript: 'while(true==this()){loopBlock();}'>
]
