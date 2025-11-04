"
This class is always included upon converting any code to javascript. 
It provides core features to bootstrap PharoJs.

It is called Smalltalk in Javascript and isn't a class proper, because it has to be in place for normal class setup. It only has ""class side"" methods.

It is output specially by the Exporter.
"
Class {
	#name : 'PjCore',
	#superclass : 'Object',
	#pools : [
		'PjUniversalGlobals'
	],
	#classInstVars : [
		'messageClass',
		'nilInJs',
		'pharoJsSelectorCache',
		'smalltalkSelectorCache',
		'metaclassClass',
		'theClassClass'
	],
	#category : 'PharoJs-Base-Transpiler-Globals',
	#package : 'PharoJs-Base-Transpiler',
	#tag : 'Globals'
}

{ #category : 'doesNotUnderstand support' }
PjCore class >> accessorTargetFor: anObject [
	"JS objects created with the brace notation are instances of Object.
	It does not make sense to add to Object getter/setters on properties of such objects."

	"Classes are functions. Their properties are equivalent to Smalltalk's class side IVs. So, they belong to the class itself"

	| prototype |
	(self isClass: anObject) ifTrue: [ ^ anObject ].
	prototype := anObject js_at: #__proto__.
	prototype == Object prototype ifTrue: [ ^ anObject ].
	^ prototype
]

{ #category : 'selector converting' }
PjCore class >> cache: aCache at: aSelector ifAbsentPut: newValue [


	(aCache js_at: aSelector) ifNil: [
		aCache js_at: aSelector put: newValue ].
]

{ #category : 'selector converting' }
PjCore class >> cache: aCache at: aSelector ifPresent: aSingleArgBlock [

	| cachedValue |
	(aCache js_hasOwnProperty: aSelector) ifFalse: [^self].
	cachedValue := aCache js_at: aSelector.
	^aSingleArgBlock value: cachedValue
]

{ #category : 'selector converting' }
PjCore class >> cacheSmalltalkSelector: stSelector pharoJsSelector: pharoJsFunctionName [
	self cache: smalltalkSelectorCache at: pharoJsFunctionName ifAbsentPut: stSelector.
	self cache: pharoJsSelectorCache at: stSelector ifAbsentPut: pharoJsFunctionName

]

{ #category : 'initalize' }
PjCore class >> emptyJavascriptObject [
	"Object.create(null) creates an even emptier JS object, but it isn't an Object (i.e. has no methods)."
	<javascript: '
		return {}
	'>
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> handleDNU: aMessage for: anObject [
	" this could be a smalltalk object or a native JS object "

	| selector |
	selector := (aMessage selector js_split: ':') js_at: 0.
	^ self
		  installDnu: selector
		  for: anObject
		  args: aMessage arguments
		  pjSelector: (self makePharoJsSelector: aMessage selector)
		  else: [
			  self error:
				  'Message not understood: ' , anObject className , '>>#'
				  , aMessage selector ]
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> hasCapitalizedName: anObject [
	"Name being a property we need to access it directly. 
	We cannot rely on accessor generation through since this method is this exact purpose.
	Otherwise we enter an infinite loop."

	| jsName firstCharacter |
	jsName := anObject js_at: #name.
	jsName = '' ifTrue: [ ^false ].
	firstCharacter := jsName first.
	^ firstCharacter = firstCharacter capitalized
]

{ #category : 'reflection support' }
PjCore class >> initInheritanceAndInstantiationLinks [

	Object js_setPrototypeOf: Object to: (theClassClass js_at: #prototype).
	Object js_setPrototypeOf: theClassClass to: PjFunction
]

{ #category : 'nil support' }
PjCore class >> initNilInJs [
	" specifically install in the global space, rather than in the Smalltalk global space "
	globalThis js_at: self nilTestFunctionName put: (self nilIfUndefined) 
]

{ #category : 'throw support' }
PjCore class >> initThrowInJs [
	" specifically install in the global space, rather than in the Smalltalk global space "
	globalThis js_at: self throwFunctionName put: (self throwFunction)
]

{ #category : 'initalize' }
PjCore class >> initializeCore [
	self resetSelectorCache.
	self initNilInJs.
	self initThrowInJs.
	self initInheritanceAndInstantiationLinks.
	self messageClass: self.
	self metaclassClass: self
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> install: aFunction named: pjSelector in: target [

	(Object js_isFrozen: target) ifFalse: [
		Object
			js_defineProperty: target
			named: pjSelector
			descriptor: (self propertyDescriptorForFunction: aFunction) ]
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> installAndPerform: selector alias: pjSelector for: anObject args: args function: aFunction [

	| target |
	target := anObject.
	[ target js_hasOwnProperty: selector ] whileFalse: [
		target := target js_at: '__proto__' ].
	self install: aFunction named: pjSelector in: target.
	^ aFunction js_apply: anObject args: args
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> installAndPerformAccessor: pjSelector property: peropertyName for: anObject args: args [

	| accessor target |
	"By default, add accessors to the prototype of the constructor.
	But, JS objects created with the brace notation are instances of Object.
	But, it does not make sense to add to Object getter/setters on properties of such objects."
	args size = 0
		ifTrue: [ accessor := self makeGetter: peropertyName ]
		ifFalse: [ accessor := self makeSetter: peropertyName ].
	target := self accessorTargetFor: anObject.
	self install: accessor named: pjSelector in: target.
	^ accessor js_apply: anObject args: args
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> installDnu: selector for: anObject args: args pjSelector: pjSelector else: aBlock [
	"anObject could be a smalltalk object or a native JS object for a JS library"

	"pjSelector is the result of transpiling a Smalltalk selector to be JS compatible see PjCore class >> #makePharoJsSelector: "

	"If a property named selector is missing 
		Then value the else block which typically signals message not understood. 
	Else
		If property is a function (js function without the PharoJS pj_ prefix) 
			Then Install an alias with pj_ prefix and perform the function/method. 
		Else  
			Install and perform a getter or a setter based on the number or args 
	"

	| property |
	(anObject hasOrInheritsProperty: selector) ifFalse: [ ^ aBlock value ].
	property := anObject instVarNamed: selector.
	(self isBasicFunction: property) ifTrue: [
		^ self
			  installAndPerform: selector
			alias: pjSelector
			  for: anObject
			  args: args
			  function: property ].
	args size > 1 ifTrue: [ ^ aBlock value ].
	^ self
		  installAndPerformAccessor: pjSelector
		  property: selector
		  for: anObject
		  args: args
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> isBasicFunction: anObject [

	(self isClassOrBasicFunction: anObject) ifFalse: [ ^ false ].
	^ (self hasCapitalizedName: anObject) not
]

{ #category : 'selector converting' }
PjCore class >> isBinarySelector: aSelector [

	| firstCharacter |
	firstCharacter := aSelector js_at: 0.
	^ (firstCharacter isLetter or: [ '$_' includes: firstCharacter ]) not
]

{ #category : 'nil support' }
PjCore class >> isBrowserPlatform [
	^ (self at: #navigator) isNotNil
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> isClass: anObject [

	(self isClassOrBasicFunction: anObject) ifFalse: [ ^false ].
	^self hasCapitalizedName: anObject

]

{ #category : 'doesNotUnderstand support' }
PjCore class >> isClassOrBasicFunction: anObject [

	<javascript: 'return "function" == typeof anObject'>
	
]

{ #category : 'nil support' }
PjCore class >> isDomPlatform [
	^ (self at: #document) isNotNil
]

{ #category : 'nil support' }
PjCore class >> isNodePlatform [
	^ (self at: #navigator) isNil
]

{ #category : 'selector converting' }
PjCore class >> isPharoJsSelector: aSelector [
	"Answer true if the argument has been generated by PharoJS"
	| prefixSize |
	prefixSize := self pharoJsSelectorPrefix size.
	aSelector size <= prefixSize ifTrue: [ ^false ].
	^ (aSelector js_substring: 0 to: prefixSize) = self pharoJsSelectorPrefix
]

{ #category : 'accessing' }
PjCore class >> javascriptName [
	<pharoJsSkip>
	^ #Smalltalk
]

{ #category : 'reflection support' }
PjCore class >> keys: anObject [
	<jsGenerator: #keys_jsGenerator:>
]

{ #category : 'reflection support' }
PjCore class >> keys_jsGenerator: transpiler [
	<pharoJsSkip>
	^'
	var result={};
	for (var i in anObject) { if(typeof anObject[i]!="function" && anObject[i]!=null && anObject[i].', transpiler pharoJsSelectorPrefix, 'proxyResponse) result[i]=anObject[i].', transpiler pharoJsSelectorPrefix, 'proxyResponse()}
	return {', transpiler pharoJsSelectorPrefix, 'proxyResponse:function(){return {keys:result}}}
	'
]

{ #category : 'logging' }
PjCore class >> log: message [
	console js_log: message
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> makeDNU: aSelector [
	<jsGenerator: #makeDNU_jsGenerator:>
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> makeDNU_jsGenerator: transpiler [
	<pharoJsSkip>
	|prefix|
	prefix := transpiler pharoJsSelectorPrefix.
	^'var pjCore=this,ss=this.', prefix, 'makeSmalltalkSelector_(aSelector);
	switch (ss.split(":").length) {
		case 1: return function __DNU(){
			return this.', prefix, 'doesNotUnderstand_(pjCore.', prefix, 'selector_arguments_(ss,[]))};
		case 2: return function __DNU(arg1) {
			return this.', prefix, 'doesNotUnderstand_(pjCore.', prefix, 'selector_arguments_(ss,[arg1]))};
		case 3: return function __DNU(arg1,arg2) {
			return this.', prefix, 'doesNotUnderstand_(pjCore.', prefix, 'selector_arguments_(ss,[arg1,arg2]))};
		default: return function __DNU() {
			var args=new Array(arguments.length);
			for(var i=0;i<arguments.length;++i) args[i]=arguments[i]
			return this.', prefix, 'doesNotUnderstand_(pjCore.', prefix, 'selector_arguments_(ss,args))};
	}'
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> makeGetter: selector [

	<javascript: 'return function(){
        if (this[selector] != null) {return this[selector]}
        return this[selector] = this.pharoJsGetterDefaultValue();        
	}'>
	
]

{ #category : 'selector converting' }
PjCore class >> makePharoJsSelector: aSelector [
	"This should comply with PjTStreamWriter >> #writeSelectorChar:on:isInBinarySelector:"

	| pjSelector |
	(self isPharoJsSelector: aSelector) ifTrue: [ ^ aSelector ].
	self
		cache: pharoJsSelectorCache
		at: aSelector
		ifPresent: [ :cachedValue | ^ cachedValue ].
	aSelector ifNotNil: [ :selector |
		(self isBinarySelector: aSelector)
			ifFalse: [
				pjSelector := (selector js_split: '_') js_join: '_$'.
				pjSelector := pjSelector js_split: ':' ]
			ifTrue: [
				pjSelector := #(  ).
				1 to: selector size do: [ :idx |
					pjSelector js_push: (selector js_charCodeAt: idx - 1) js_toString ].
				pjSelector js_push: nil ].
		pjSelector := self pharoJsSelectorPrefix , (pjSelector js_join: '_') ].
	self cacheSmalltalkSelector: aSelector pharoJsSelector: pjSelector.
	^ pjSelector
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> makeSetter: selector [

	<javascript:
	'return function (value){return this[selector]=value}'>
	
]

{ #category : 'selector converting' }
PjCore class >> makeSmalltalkSelector: aSelector [

	| stSelector trimmed columnsIntroduced |
	(self isPharoJsSelector: aSelector) ifFalse: [ ^ aSelector ].
	self
		cache: smalltalkSelectorCache
		at: aSelector
		ifPresent: [ :cachedValue | ^ cachedValue ].
	trimmed := aSelector copyFrom: self pharoJsSelectorPrefix size + 1.
	columnsIntroduced := trimmed
		                     js_replace:
		                     self
			                     underscoreNotFollowdByDollarRegularExpression
		                     with: ':'.
	stSelector := columnsIntroduced copyWithout: '$'.
	self cacheSmalltalkSelector: stSelector pharoJsSelector: aSelector.
	^ stSelector
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> messageClass: anObject [
	messageClass := anObject
]

{ #category : 'reflection support' }
PjCore class >> metaclassClass: anObject [
	metaclassClass := anObject
]

{ #category : 'reflection support' }
PjCore class >> metaclassOf: aClass [
	<jsGenerator: #metaclassOf_jsGenerator:>
]

{ #category : 'reflection support' }
PjCore class >> metaclassOf_jsGenerator: transpiler [
	<pharoJsSkip>
	^'if(this.metaclassClass!==this) return this.metaclassClass.', transpiler pharoJsSelectorPrefix, 'metaclassOf_(aClass);
	var theMetaClass={ prototype: aClass.__proto__,__proto__:this.theClassClass.prototype,
		', transpiler pharoJsSelectorPrefix, 'name: function(){return aClass.', transpiler pharoJsSelectorPrefix, 'name()+" class"},
		', transpiler pharoJsSelectorPrefix, 'theNonMetaClass: function(){return aClass},
		', transpiler pharoJsSelectorPrefix, 'theMetaClass: function(){return theMetaClass},
		};
	return theMetaClass
	'
]

{ #category : 'nil support' }
PjCore class >> nilIfUndefined [
	"In case PjUndefinedObject is not created yet, use a placeholder object, just for declaring."
	<javascript: 'globalThis.PjUndefinedObject |= {};
	return function(arg){if(arg == undefined){
		return PjUndefinedObject.uniqueInstance;
	}
	return arg}'>
	
]

{ #category : 'nil support' }
PjCore class >> nilTestFunctionName [
	^ '$asNil$'
]

{ #category : 'selector converting' }
PjCore class >> pharoJsSelectorPrefix [
	<jsGenerator: #pharoJsSelectorPrefix_jsGenerator:>
	^ self error: 'Only for Javascript side'
]

{ #category : 'selector converting' }
PjCore class >> pharoJsSelectorPrefix_jsGenerator: transpiler [
	<pharoJsSkip>
	^ 'return ',transpiler pharoJsSelectorPrefix asJSON
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> propertyDescriptorForFunction: func [

	<javascript: 'return {
		enumerable: false,
		configurable: true,
		writable: true,
		value: func}'>
	
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> registerDnu: aSelector [
	| selector props |
	selector := self makePharoJsSelector: aSelector.
	((Object js_at: #prototype) js_hasOwnProperty: selector) ifFalse: [
		props := self makeDNU: aSelector.
		Object
			js_defineProperty: (Object js_at:#prototype)
			named: selector
			descriptor: (self propertyDescriptorForFunction: props)
	].
	^ selector
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> registerDnuForAll: anArray [
	anArray js_forEach: [ : each | self registerDnu: each ]
]

{ #category : 'importing' }
PjCore class >> require: moduleName [

	<jsAlias: #require>
	<javascript: 'return require(moduleName);'>
	^ globalThis require: moduleName
]

{ #category : 'selector converting' }
PjCore class >> resetSelectorCache [

	pharoJsSelectorCache := self emptyJavascriptObject.
	smalltalkSelectorCache := self emptyJavascriptObject
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> selector: selector arguments: args [
	<jsGenerator: #selector_arguments_jsGenerator:>
]

{ #category : 'doesNotUnderstand support' }
PjCore class >> selector_arguments_jsGenerator: transpiler [
	<pharoJsSkip>
	^'if(this.messageClass!==this)
		return this.messageClass.', transpiler pharoJsSelectorPrefix, 'selector_arguments_(selector,arguments);
	return {
			selector: selector,
			', transpiler pharoJsSelectorPrefix, 'selector: function(){return this.selector},
			arguments: args,
			', transpiler pharoJsSelectorPrefix, 'arguments: function(){return this.arguments}
		}'
]

{ #category : 'throw support' }
PjCore class >> throwFunction [
	<javascript: 'return function(arg){throw arg}'>
]

{ #category : 'throw support' }
PjCore class >> throwFunctionName [
	^ '$throw$'
]

{ #category : 'selector converting' }
PjCore class >> underscoreNotFollowdByDollarRegularExpression [

	<javascript: 'return /_(?!\$)/g'>
	^ self error: 'Only for Javascript side'
]
