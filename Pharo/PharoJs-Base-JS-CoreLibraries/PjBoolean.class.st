"
I represent the Javascript Boolean type.  Many of my operations may be optimized away, in which case these are fallbacks for perform: etc.
"
Class {
	#name : #PjBoolean,
	#superclass : #PjObject,
	#traits : 'PjTKernelClass',
	#classTraits : 'PjTKernelClass classTrait',
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'class initialization' }
PjBoolean class >> identityHash_jsGenerator: transpiler [
	<pharoJsSkip>
	^'if(this == true){
		return ', true identityHash asString,';}
	return ', false identityHash asString
]

{ #category : #'pharoJs support' }
PjBoolean class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ { (Boolean -> #( ==> eqv: isLiteral)) }
]

{ #category : #'logical operations' }
PjBoolean >> & aBoolean [
	^ self ifTrue: [ ^ aBoolean ] ifFalse: [ ^ false ]
]

{ #category : #comparing }
PjBoolean >> = other [
	<javascript: 'return this==Boolean(other)'>
]

{ #category : #comparing }
PjBoolean >> == other [
	^ self = other
]

{ #category : #controlling }
PjBoolean >> and: aBlock [
	<javascript: 'if(this==true){return aBlock();}else{return false;}'>
]

{ #category : #converting }
PjBoolean >> asBit [
	<javascript: 'return this + 0'>
]

{ #category : #converting }
PjBoolean >> asJsObject [
	"We want primitive booleans and not boxed ones!"
	"This is necessary because if a value like true is sent as a message, then it is wrapped, so returning this doesn’t do the right thing. so the block [ false not == true ] will return false."
	<javascript: 'return this == true'>
]

{ #category : #converting }
PjBoolean >> asString [
	<javascript: 'return this + ""'>
]

{ #category : #'not defined category' }
PjBoolean >> identityHash [
	<jsGenerator: #identityHash_jsGenerator:>
]

{ #category : #controlling }
PjBoolean >> ifFalse: aBlock [
	^ self ifTrue: [] ifFalse: aBlock
]

{ #category : #controlling }
PjBoolean >> ifFalse: falseBlock ifTrue: trueBlock [
	^self ifTrue: trueBlock ifFalse: falseBlock
]

{ #category : #controlling }
PjBoolean >> ifTrue: aBlock [
	^ self ifTrue: aBlock ifFalse: [  ]
]

{ #category : #controlling }
PjBoolean >> ifTrue: trueBlock ifFalse: falseBlock [
	<javascript: 'if(this==true){return typeof trueBlock=="function"?trueBlock():trueBlock}else{return typeof falseBlock=="function"?falseBlock():falseBlock}'>
]

{ #category : #testing }
PjBoolean >> isJSPrimitiveType [
	^ true
]

{ #category : #'logical operations' }
PjBoolean >> not [
	^ self ifTrue: [ ^ false ] ifFalse: [ ^ true ]
]

{ #category : #controlling }
PjBoolean >> or: aBlock [
	<javascript: 'if(this==true){return true}else{return aBlock()}'>
]

{ #category : #printing }
PjBoolean >> printOn: aStream [

	aStream nextPutAll: self asString
]

{ #category : #proxy }
PjBoolean >> proxyResponse [
	<javascript: 'return true==this'>
]

{ #category : #converting }
PjBoolean >> value [
	<javascript: 'return true==this'>
]

{ #category : #controlling }
PjBoolean >> xor: aBoolean [
	self ifTrue: [ ^ aBoolean value not ] ifFalse: [ ^ aBoolean value ]
]

{ #category : #'logical operations' }
PjBoolean >> | aBoolean [
	^ self ifFalse: [ ^ aBoolean ] ifTrue: [ ^ true ]
]

{ #category : #comparing }
PjBoolean >> ~~ other [
	^ self ~= other
]
