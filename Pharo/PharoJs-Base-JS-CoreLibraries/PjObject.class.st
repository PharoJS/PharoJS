"
I represent the top-level Object constructor/class in Javascript

All my direct subclasses exist as constructors/types in Javascript.  The classes exist to replace Smalltalk primitives or inlining.

Methods from these classes are added to the built-in constructor prototypes or directly in the constructors.
"
Class {
	#name : 'PjObject',
	#superclass : 'Object',
	#traits : 'PjTKernelClass',
	#classTraits : 'PjTKernelClass classTrait',
	#pools : [
		'PjDomGlobals'
	],
	#classInstVars : [
		'nextIdentityHash'
	],
	#category : 'PharoJs-Base-JS-CoreLibraries-Kernel',
	#package : 'PharoJs-Base-JS-CoreLibraries',
	#tag : 'Kernel'
}

{ #category : 'doesNotUnderstand support' }
PjObject class >> addDnuSupportFor: selector [
	<javascript: 'if(Object.prototype.hasOwnProperty(selector)){return;}
		Object.prototype.selector =  function(){
			throw "Does not understand message " + selector;};
	'>
	self flag: #todo "see JbObject>>#registerDNU:"
]

{ #category : 'reflection' }
PjObject class >> allEnumeratableKeysDo_jsGenerator: transpiler [
	<pharoJsSkip>
	^'for (var i in this){aBlock.', transpiler pharoJsSelectorPrefix, 'value_(i)};
	return this;'
]

{ #category : 'pharoJs support' }
PjObject class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ {
		  (ProtoObject
		   -> #( isNil ifNil: ifNotNil: #ifNil:ifNotNil: #ifNotNil:ifNil: )).
		  (Object
		   ->
			   #( -> as: isKindOf: error: respondsTo:
			      isMemberOf: className isNotNil notNil isString isClass
			      isBlock isNumber isBehavior isCollection isArray isFloat
			      isInteger isCharacter isSymbol isStream isPjProxyOrNil
			      printOn: shouldBePrintedAsLiteral shouldBePrintedAsLiteral:
			      isLiteral isSelfEvaluating isSelfEvaluating:
			      isPoint isTrait)).
		  (Collection
		   -> #( addAll: #ifEmpty:ifNotEmpty: #ifNotEmpty:ifEmpty:
			      ifEmpty: ifNotEmpty: )).
		  (Dictionary -> #( do: )).
		  (Dictionary class -> #( newFrom: newFromPairs: )) }
]

{ #category : 'dictionary emulation' }
PjObject class >> keysAndValuesDo_jsGenerator: transpiler [
	<pharoJsSkip>
	^'for (var i in this){if(this.hasOwnProperty(i))aBlock.', transpiler pharoJsSelectorPrefix, 'value_value_(i,this[i])};
	return this;'
]

{ #category : 'dictionary emulation' }
PjObject class >> keysDo_jsGenerator: transpiler [
	<pharoJsSkip>
	^'for (var i in this){if(this.hasOwnProperty(i))aBlock.', transpiler pharoJsSelectorPrefix, 'value_(i)};
	return this;'
]

{ #category : 'comparing' }
PjObject class >> nextIdentityHash [
	^ nextIdentityHash := (nextIdentityHash ifNil: [12345]) hashMultiply
]

{ #category : 'dictionary emulation' }
PjObject class >> valuesDo_jsGenerator: transpiler [
	<pharoJsSkip>
	^'for (var i in this){if(this.hasOwnProperty(i))aBlock.', transpiler pharoJsSelectorPrefix, 'value_(this[i])};
	return this;'
]

{ #category : 'comparing' }
PjObject >> = other [
	<javascript: 'return this==other'>
]

{ #category : 'comparing' }
PjObject >> == other [
	<javascript: 'return this===other'>
]

{ #category : 'dictionary emulation' }
PjObject >> add: assoc [
	" this strange code is to install add: for objects that already have an add field or to do at:put: "

	^ PjCore
		  installDnu: #add
		  for: self
		  args: { assoc }
		  pjSelector: #_add_
		  else: [ self js_at: assoc key put: assoc value ]
]

{ #category : 'reflection' }
PjObject >> allEnumeratableKeys [
	| allKeys |
	allKeys := Set new.
	self allEnumeratableKeysDo: [ : each | allKeys add: each ].
	^allKeys
]

{ #category : 'reflection' }
PjObject >> allEnumeratableKeysDo: aBlock [
	<jsGenerator: #allEnumeratableKeysDo_jsGenerator:>
]

{ #category : 'converting' }
PjObject >> asJSON [
	^ JSON stringify: self value
]

{ #category : 'converting' }
PjObject >> asJsObject [
	^self
]

{ #category : 'dictionary emulation' }
PjObject >> associationsDo: aBlock [
	self keysAndValuesDo: [: key : value |
		aBlock value: (Association key: key value: value)
	]
]

{ #category : 'dictionary emulation' }
PjObject >> at: key [
	<javascript: 'return this[key]'>
]

{ #category : 'dictionary emulation' }
PjObject >> at: key ifAbsent: aBlock [
	(self js_hasOwnProperty: key) ifTrue: [ ^self js_at: key].
	^ aBlock value
]

{ #category : 'dictionary emulation' }
PjObject >> at: key ifPresent: aBlock [
	(self js_hasOwnProperty: key) ifFalse: [ ^ nil].
	^ aBlock cull: (self js_at: key)
]

{ #category : 'dictionary emulation' }
PjObject >> at: key ifPresent: aBlock ifAbsent: anotherBlock [
	(self js_hasOwnProperty: key) ifTrue: [ ^ aBlock cull: (self js_at: key)].
	^ anotherBlock value
]

{ #category : 'dictionary emulation' }
PjObject >> at: key put: value [
	<javascript: 'return this[key]=value'>
]

{ #category : 'converting' }
PjObject >> becomeJsObject [

	^ self
]

{ #category : 'reflection' }
PjObject >> class [
	^ self js_at: #constructor
]

{ #category : 'copying' }
PjObject >> copy [
	^self shallowCopy postCopy
]

{ #category : 'reflection' }
PjObject >> doesNotUnderstand: aMessage [
	^ PjCore handleDNU: aMessage for: self
]

{ #category : 'flagging' }
PjObject >> flag: aSymbol [
]

{ #category : 'reflection' }
PjObject >> halt [
	<javascript: 'debugger'>
]

{ #category : 'testing' }
PjObject >> hasOrInheritsProperty: propertyName [
	"The `in` operator cannot be used for some data types such as strings"

	| property |
	property := self js_at: propertyName.
	property ifNotNil: [ ^ true ].
	self isObjectOrFunction ifTrue: [^self jsHasOrInheritsProperty: propertyName ].
	^ self hasOwnProperty: propertyName
]

{ #category : 'comparing' }
PjObject >> hash [
	^ self identityHash
]

{ #category : 'comparing' }
PjObject >> identityHash [
	^ (self instVarNamed: #_js_hash) ifNil: [
		self instVarNamed: #_js_hash putHidden: self class nextIdentityHash ]
]

{ #category : 'dictionary emulation' }
PjObject >> includesKey: key [
	<javascript: 'return this.hasOwnProperty(key)'>
]

{ #category : 'initialize-release' }
PjObject >> initialize [
]

{ #category : 'introspection' }
PjObject >> instVarNamed: aString [
	^ self js_at: aString
]

{ #category : 'introspection' }
PjObject >> instVarNamed: aString put: anObject [
	^ self js_at: aString put: anObject
]

{ #category : 'introspection' }
PjObject >> instVarNamed: aString putHidden: anObject [
	<javascript: '
	try{Object.defineProperty(this,aString,{value:anObject,writable:true})}catch(e){}
	return anObject'>
]

{ #category : 'dictionary emulation' }
PjObject >> isEmpty [
	self keysDo: [ ^ false ].
	^ true
]

{ #category : 'dictionary emulation' }
PjObject >> isEmptyOrNil [
	^ false
]

{ #category : 'testing' }
PjObject >> isJSPrimitiveType [
	^ false
]

{ #category : 'testing' }
PjObject >> isObjectOrFunction [
	| type |
	type := self typeof.
	^type = 'object' or: [ type = 'function' ]
]

{ #category : 'dictionary emulation' }
PjObject >> jsHasOrInheritsProperty: propertyName [
	<javascript: 'return propertyName in this'>
]

{ #category : 'dictionary emulation' }
PjObject >> keys [
	"Answer an Array containing the receiver's keys."
	| result |
	result := Array new.
	self keysDo: [:key| result addLast: key].
	^ result
]

{ #category : 'dictionary emulation' }
PjObject >> keysAndValuesDo: aBlock [
	<jsGenerator: #keysAndValuesDo_jsGenerator:>
]

{ #category : 'dictionary emulation' }
PjObject >> keysDo: aBlock [
	<jsGenerator: #keysDo_jsGenerator:>
]

{ #category : 'message performing' }
PjObject >> perform: selector [
	^ (self js_at: (PjCore registerDnu: selector)) call: self
]

{ #category : 'message performing' }
PjObject >> perform: selector with: arg [
	^ (self js_at: (PjCore registerDnu: selector)) call: self with: arg
]

{ #category : 'message performing' }
PjObject >> perform: selector with: arg1 with: arg2 [
	^ (self js_at: (PjCore registerDnu: selector)) call: self with: arg1 with: arg2
]

{ #category : 'message performing' }
PjObject >> perform: selector with: arg1 with: arg2 with: arg3 [
	^ (self js_at: (PjCore registerDnu: selector)) call: self with: arg1 with: arg2 with: arg3
]

{ #category : 'message performing' }
PjObject >> perform: selector withArguments: argArray [
	^ (self js_at: (PjCore registerDnu: selector)) apply: self with: argArray
]

{ #category : 'message performing' }
PjObject >> perform: selector withArguments: argArray inSuperclass: lookupClass [
	^ (lookupClass prototype js_at: (PjCore registerDnu: selector)) apply: self with: argArray
]

{ #category : 'doesNotUnderstand support' }
PjObject >> pharoJsGetterDefaultValue [
	"Used by getters dynamically generated. See PjCore class >> #makeGetter: "

	<jsAlias: 'pharoJsGetterDefaultValue'>
	^ nil
]

{ #category : 'copying' }
PjObject >> postCopy [
	^self
]

{ #category : 'printing' }
PjObject >> printString [

	^String streamContents: [ : stream | self printOn: stream ]
]

{ #category : 'proxy' }
PjObject >> proxyResponse [
	<PjTodo: 'not sure if proxyResponse is a good name'>
	| assoc p |
	assoc := PjProxyManager ensureObjectRegistered: self.
	p := PjProxyInfo new.
	p oid: assoc key.
	p remove: (self instVarNamed: '$PjProxyRemove').
	p globalName: assoc value.
	^ p
]

{ #category : 'initialize-release' }
PjObject >> release [
]

{ #category : 'dictionary emulation' }
PjObject >> removeKey: key [
	<javascript: 'var result=this[key];delete this[key];return result'>
]

{ #category : 'process operations' }
PjObject >> setTimeout: aBlock afterMilliseconds: anInteger [
	<javascript: 'globalThis.setTimeout(aBlock, anInteger)'>
	super setTimeout: aBlock afterMilliseconds: anInteger
]

{ #category : 'copying' }
PjObject >> shallowCopy [
	| copy |
	copy := self class basicNew.
	self keysAndValuesDo: [ : key : value |
		copy instVarNamed: key put: value ].
	^copy
]

{ #category : 'accessing' }
PjObject >> size [
	| count |
	count := 0.
	self keysDo: [: value |
		count := count + 1
	].
	^ count
]

{ #category : 'reflection' }
PjObject >> species [
	^ self class
]

{ #category : 'reflection' }
PjObject >> typeof [
	<javascript: 'return typeof this'>
]

{ #category : 'reflection' }
PjObject >> typeof: anObject [
	<javascript: 'return typeof anObject'>
]

{ #category : 'testing' }
PjObject >> value [
	" this strange code is to install _value for objects that already have a value field or to return self "

	^ PjCore
		  installDnu: #value
		  for: self
		  args: #(  )
		  pjSelector: PjCore pharoJsSelectorPrefix , 'value'
		  else: [ self ]
]

{ #category : 'dictionary emulation' }
PjObject >> valuesDo: aBlock [
	<jsGenerator: #valuesDo_jsGenerator:>
]

{ #category : 'accessing' }
PjObject >> yourself [
	^self
]

{ #category : 'comparing' }
PjObject >> ~= other [
	^ (self = other) not
]

{ #category : 'comparing' }
PjObject >> ~~ other [
	^ (self == other) not
]
