"
I represent the top-level Object constructor/class in Javascript

All my direct subclasses exist as constructors/types in Javascript.  The classes exist to replace Smalltalk primitives or inlining.

Methods from these classes are added to the built-in constructor prototypes or directly in the constructors.
"
Class {
	#name : #PjObject,
	#superclass : #Object,
	#traits : 'PjTExtensionClass',
	#classTraits : 'PjTExtensionClass classTrait',
	#pools : [
		'PjDomGlobals'
	],
	#classInstVars : [
		'nextIdentityHash'
	],
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'doesNotUnderstand support' }
PjObject class >> addDnuSupportFor: selector [
	<javascript: 'if(Object.prototype[selector] != undefined){return;}
		Object.prototype.selector =  function(){
			throw "Does not understand message " + selector;};
	'>
	self flag: #todo "see JbObject>>#registerDNU:"

]

{ #category : #'pharoJs support' }
PjObject class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{ProtoObject -> #(
				isNil ifNil: ifNotNil: ifNil:ifNotNil: ifNotNil:ifNil:
			).
		Object -> #(
				-> as: asOrderedCollection 
				isKindOf: error: respondsTo: isMemberOf: className
				isNotNil notNil isString isClass isBlock isNumber isBehavior 
				isCollection isArray isFloat isInteger isCharacter isSymbol isStream
			).
		Collection -> #(
				addAll: 
			).
		Dictionary -> #(
				do: 
			).
		Dictionary class -> #(
				newFrom: newFromPairs: 
			).
		}
]

{ #category : #comparing }
PjObject class >> nextIdentityHash [
	^ nextIdentityHash := (nextIdentityHash ifNil: [12345]) hashMultiply
]

{ #category : #proxy }
PjObject class >> resultObject: result [
	<javascript: '
		if (result != undefined) return result._proxyResponse();
		return null;
	'>
]

{ #category : #comparing }
PjObject >> = other [
	<javascript: 'return this==other'>
]

{ #category : #comparing }
PjObject >> == other [
	<javascript: 'return this===other'>
]

{ #category : #'dictionary emulation' }
PjObject >> add: assoc [

" this strange code is to install _value for objects that already have a value field or to return self "
	^ PjCore installDNU: nil arguments: {assoc} selector: #add js: #_add_ for: self else: [
		self js_at: assoc key put: assoc value
	]
]

{ #category : #converting }
PjObject >> asJSON [
	^ JSON stringify: self value
]

{ #category : #'dictionary emulation' }
PjObject >> associationsDo: aBlock [
	self keysAndValuesDo: [: key : value |
		aBlock value: (Association key: key value: value)
	]
]

{ #category : #'dictionary emulation' }
PjObject >> at: key [
	<javascript: 'return this[key]'>
]

{ #category : #'dictionary emulation' }
PjObject >> at: key ifAbsent: aBlock [
	(self js_hasOwnProperty: key) ifTrue: [ ^self js_at: key].
	^ aBlock value
]

{ #category : #'dictionary emulation' }
PjObject >> at: key ifPresent: aBlock [
	(self js_hasOwnProperty: key) ifFalse: [ ^ nil].
	^ aBlock cull: (self js_at: key)
]

{ #category : #'dictionary emulation' }
PjObject >> at: key ifPresent: aBlock ifAbsent: anotherBlock [
	(self js_hasOwnProperty: key) ifTrue: [ ^ aBlock cull: (self js_at: key)].
	^ anotherBlock value
]

{ #category : #'dictionary emulation' }
PjObject >> at: key put: value [
	<javascript: 'return this[key]=value'>
]

{ #category : #reflection }
PjObject >> class [
	^ self js_at: #constructor
]

{ #category : #reflection }
PjObject >> doesNotUnderstand: aMessage [
	^ PjCore handleDNU: aMessage for: self
]

{ #category : #flagging }
PjObject >> flag: aSymbol [
]

{ #category : #comparing }
PjObject >> hash [
	^ self identityHash
]

{ #category : #comparing }
PjObject >> identityHash [
	^ (self instVarNamed: #_js_hash) ifNil: [
		self instVarNamed: #_js_hash putHidden: self class nextIdentityHash ]
]

{ #category : #'dictionary emulation' }
PjObject >> includesKey: key [
	<javascript: 'return this.hasOwnProperty(key)'>
]

{ #category : #'initialize-release' }
PjObject >> initialize [
	
]

{ #category : #introspection }
PjObject >> instVarNamed: aString [
	^ self js_at: aString
]

{ #category : #introspection }
PjObject >> instVarNamed: aString put: anObject [
	^ self js_at: aString put: anObject
]

{ #category : #introspection }
PjObject >> instVarNamed: aString putHidden: anObject [
	<javascript: '
	try{Object.defineProperty(this,aString,{value:anObject,writable:true})}catch(e){}
	return anObject'>
]

{ #category : #'dictionary emulation' }
PjObject >> isEmpty [
	self keysDo: [ ^ false ].
	^ true
]

{ #category : #'dictionary emulation' }
PjObject >> keys [
	"Answer an Array containing the receiver's keys."
	| result |
	result := Array new.
	self keysDo: [:key| result addLast: key].
	^ result
]

{ #category : #'dictionary emulation' }
PjObject >> keysAndValuesDo: aBlock [
	<javascript:
	'for (var i in this){if(this.hasOwnProperty(i))aBlock._value_value_(i,this[i])};
	return this;'>
]

{ #category : #'dictionary emulation' }
PjObject >> keysDo: aBlock [
	<javascript:
	'for (var i in this){if(this.hasOwnProperty(i))aBlock._value_(i)};
	return this;'>
]

{ #category : #'message performing' }
PjObject >> perform: selector [
	^ (self js_at: (PjCore registerDnu: selector)) call: self
]

{ #category : #'message performing' }
PjObject >> perform: selector with: arg [
	^ (self js_at: (PjCore registerDnu: selector)) call: self with: arg
]

{ #category : #'message performing' }
PjObject >> perform: selector with: arg1 with: arg2 [
	^ (self js_at: (PjCore registerDnu: selector)) call: self with: arg1 with: arg2
]

{ #category : #'message performing' }
PjObject >> perform: selector with: arg1 with: arg2 with: arg3 [
	^ (self js_at: (PjCore registerDnu: selector)) call: self with: arg1 with: arg2 with: arg3
]

{ #category : #'message performing' }
PjObject >> perform: selector withArguments: argArray [
	^ (self js_at: (PjCore registerDnu: selector)) apply: self with: argArray
]

{ #category : #'message performing' }
PjObject >> perform: selector withArguments: argArray inSuperclass: lookupClass [
	^ (lookupClass prototype js_at: (PjCore registerDnu: selector)) apply: self with: argArray
]

{ #category : #proxy }
PjObject >> proxyResponse [
	<javascript:
	'var name = this.$_jsName;
	if (!name) {
		Object.$Pj_counter = (Object.$Pj_counter||0)+1;
		name = "$_"+Object.$Pj_counter;
		(function(){return this})()[name]=this;
		try{Object.defineProperty(this,"$_jsName",{value:name,writable:true})}catch(e){}
	}
	return { remove : this.$PjProxyRemove , proxy : name}
	'>
]

{ #category : #'dictionary emulation' }
PjObject >> removeKey: key [
	<javascript: 'var result=this[key];delete this[key];return result'>
]

{ #category : #'dictionary emulation' }
PjObject >> size [
	| count |
	count := 0.
	self keysAndValuesDo: [: key : value |
		count := count + 1
	].
	^ count
]

{ #category : #reflection }
PjObject >> species [
	^ self class
]

{ #category : #reflection }
PjObject >> typeof [
	<javascript: 'return typeof this'>
]

{ #category : #reflection }
PjObject >> typeof: anObject [
	<javascript: 'return typeof anObject'>
]

{ #category : #testing }
PjObject >> value [

" this strange code is to install _value for objects that already have a value field or to return self "
	^ PjCore installDNU: nil arguments: #() selector: #value js: #_value for: self else: [
		self
	]
]

{ #category : #'dictionary emulation' }
PjObject >> valuesDo: aBlock [
	<javascript:
	'for (var i in this){if(this.hasOwnProperty(i))aBlock._value_(this[i])};
	return this;'>
]

{ #category : #accessing }
PjObject >> yourself [
	^self
]

{ #category : #comparing }
PjObject >> ~= other [
	^ (self = other) not
]

{ #category : #comparing }
PjObject >> ~~ other [
	^ (self == other) not
]
