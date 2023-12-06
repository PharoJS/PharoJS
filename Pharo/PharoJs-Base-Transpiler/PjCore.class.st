"
This class is always included upon converting any code to javascript. 
It provides core features to bootstrap PharoJs.

It is called Smalltalk in Javascript and isn't a class proper, because it has to be in place for normal class setup. It only has ""class side"" methods.

It is output specially by the Exporter.
"
Class {
	#name : #PjCore,
	#superclass : #Object,
	#pools : [
		'PjUniversalGlobals'
	],
	#classInstVars : [
		'messageClass',
		'nilInJs',
		'selectorCache',
		'metaclassClass',
		'theClassClass'
	],
	#category : #'PharoJs-Base-Transpiler-Globals'
}

{ #category : #'doesNotUnderstand support' }
PjCore class >> accessorTargetFor: anObject [
	"JS objects created with the brace notation are instances of Object.
	It does not make sense to add to Object getter/setters on properties of such objects."

	"Classes are functions. Their properties are equivalent to Smalltalk's class side IVs. So, they belong to the class itself"

	| prototype |
	(self isFunction: anObject) ifTrue: [
		^ anObject ].
	prototype := anObject js_at: #__proto__.
	prototype == Object prototype ifTrue: [
		^ anObject ].
	^ prototype
]

{ #category : #initalize }
PjCore class >> emptyJavascriptObject [
	"Object.create(null) creates an even emptier JS object, but it isn't an Object (i.e. has no methods)."
	<javascript: '
		return {}
	'>
]

{ #category : #'doesNotUnderstand support' }
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

{ #category : #'reflection support' }
PjCore class >> initInheritanceAndInstantiationLinks [

	Object js_setPrototypeOf: Object to: (theClassClass js_at: #prototype).
	Object js_setPrototypeOf: theClassClass to: PjFunction
]

{ #category : #'nil support' }
PjCore class >> initNilInJs [
	" specifically install in the global space, rather than in the Smalltalk global space "
	globalThis js_at: self nilTestFunctionName put: (self nilIfUndefined) 
]

{ #category : #'throw support' }
PjCore class >> initThrowInJs [
	" specifically install in the global space, rather than in the Smalltalk global space "
	globalThis js_at: self throwFunctionName put: (self throwFunction)
]

{ #category : #initalize }
PjCore class >> initializeCore [
	selectorCache := self emptyJavascriptObject.
	self initNilInJs.
	self initThrowInJs.
	self initInheritanceAndInstantiationLinks.
	self messageClass: self.
	self metaclassClass: self.
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> installAndPerformAccessor: pjSelector property: peropertyName for: anObject args: args [

	| accessor target |
	"By default, add accessors to the prototype of the constructor.
	But, JS objects created with the brace notation are instances of Object.
	But, it does not make sense to add to Object getter/setters on properties of such objects."
	args size = 0
		ifTrue: [ accessor := self makeGetter: peropertyName ]
		ifFalse: [ accessor := self makeSetter: peropertyName ].
	target := self accessorTargetFor: anObject.
	Object
		js_defineProperty: target
		field: pjSelector
		properties: (self propertySet: accessor).
	^ accessor js_apply: anObject args: args
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> installAndPerformAlias: pjSelector for: anObject args: args function: aFunction [

		Object
		js_defineProperty: anObject
		field: pjSelector
		properties: (self propertySet: aFunction).
	^ aFunction js_apply: anObject args: args
]

{ #category : #'doesNotUnderstand support' }
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
	(self isFunction: property) ifTrue: [
		^ self
			  installAndPerformAlias: pjSelector
			  for: anObject
			  args: args
			  function: property ].
	args size > 1 ifTrue: [ ^ aBlock value ].
	^ self installAndPerformAccessor: pjSelector property: selector for: anObject args: args
]

{ #category : #'nil support' }
PjCore class >> isBrowserPlatform [
	^ (self at: #navigator) isNotNil
]

{ #category : #'nil support' }
PjCore class >> isDomPlatform [
	^ (self at: #document) isNotNil
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> isFunction: type [
	<javascript: 'return "function" == typeof type'>
]

{ #category : #'nil support' }
PjCore class >> isNodePlatform [
	^ (self at: #navigator) isNil
]

{ #category : #accessing }
PjCore class >> isPharoJsSelector: aSelector [
	"Answer true if the argument has been generated by PharoJS"
	| prefixSize |
	prefixSize := self pharoJsSelectorPrefix size.
	aSelector size <= prefixSize ifTrue: [ ^false ].
	^ (aSelector js_substring: 0 to: prefixSize) = self pharoJsSelectorPrefix
]

{ #category : #accessing }
PjCore class >> javascriptName [
	<pharoJsSkip>
	^ #Smalltalk
]

{ #category : #'reflection support' }
PjCore class >> keys: anObject [
	<jsGenerator: #keys_jsGenerator:>
]

{ #category : #'reflection support' }
PjCore class >> keys_jsGenerator: transpiler [
	<pharoJsSkip>
	^'
	var result={};
	for (var i in anObject) { if(typeof anObject[i]!="function" && anObject[i]!=null && anObject[i].', transpiler pharoJsSelectorPrefix, 'proxyResponse) result[i]=anObject[i].', transpiler pharoJsSelectorPrefix, 'proxyResponse()}
	return {', transpiler pharoJsSelectorPrefix, 'proxyResponse:function(){return {keys:result}}}
	'
]

{ #category : #logging }
PjCore class >> log: message [
	console js_log: message
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> makeDNU: aSelector [
	<jsGenerator: #makeDNU_jsGenerator:>
]

{ #category : #'doesNotUnderstand support' }
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

{ #category : #'doesNotUnderstand support' }
PjCore class >> makeGetter: selector [

	<javascript: 'return function(){
        if (this[selector] != null) {return this[selector]}
        return this[selector] = this.pharoJsGetterDefaultValue();        
	}'>
	
]

{ #category : #accessing }
PjCore class >> makePharoJsSelector: aSelector [
	| result |
	(self isPharoJsSelector: aSelector)
		ifTrue: [ ^ aSelector ].
	(selectorCache js_hasOwnProperty: aSelector)
		ifTrue: [ ^ selectorCache js_at: aSelector ].
	aSelector
		ifNotNil: [ :sel | 
			(sel isLetter or: [ (aSelector js_at: 0) = '$' ])
				ifTrue: [ result := sel js_split: ':' ]
				ifFalse: [ result := #().
					1 to: sel size do:
						[ :idx | result js_push: (sel js_charCodeAt: idx - 1) js_toString ].
					result js_push: nil ].
			result := self pharoJsSelectorPrefix , (result js_join: '_') ].
	(selectorCache js_at: result)
		ifNil: [ selectorCache js_at: result put: aSelector ].
	(selectorCache js_at: aSelector)
		ifNil: [ selectorCache js_at: aSelector put: result ].
	^ result
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> makeSetter: selector [

	<javascript:
	'return function (value){return this[selector]=value}'>
	
]

{ #category : #accessing }
PjCore class >> makeSmalltalkSelector: aSelector [
	| result |
	(self isPharoJsSelector: aSelector) ifFalse: [ ^ aSelector ].
	(selectorCache js_hasOwnProperty: aSelector) ifTrue: [
		^ selectorCache js_at: aSelector ].
	result := aSelector js_split: '_'.
	result js_shift.
	((result js_at: 0) js_at: 0) > '9' ifTrue: [ ^ result js_join: ':' ].
	result js_pop.
	0 to: (result js_at: #length)-1 do: [ :index |
		result js_at: index put: (Character value: (result js_at: index)) ].
	result := result js_join: ''.
	(selectorCache js_at: result) ifNil: [ selectorCache js_at: result put: aSelector ].
	(selectorCache js_at: aSelector) ifNil: [ selectorCache js_at: aSelector put: result ].
	^ result
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> messageClass: anObject [
	messageClass := anObject
]

{ #category : #'reflection support' }
PjCore class >> metaclassClass: anObject [
	metaclassClass := anObject
]

{ #category : #'reflection support' }
PjCore class >> metaclassOf: aClass [
	<jsGenerator: #metaclassOf_jsGenerator:>
]

{ #category : #'reflection support' }
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

{ #category : #'nil support' }
PjCore class >> nilIfUndefined [
	"In case PjUndefinedObject is not created yet, use a placeholder object, just for declaring."
	<javascript: 'globalThis.PjUndefinedObject |= {};
	return function(arg){if(arg == undefined){
		return PjUndefinedObject.uniqueInstance;
	}
	return arg}'>
	
]

{ #category : #'nil support' }
PjCore class >> nilTestFunctionName [
	^ '$asNil$'
]

{ #category : #accessing }
PjCore class >> pharoJsSelectorPrefix [
	<jsGenerator: #pharoJsSelectorPrefix_jsGenerator:>
	^ self error: 'Only for Javascript side'
]

{ #category : #accessing }
PjCore class >> pharoJsSelectorPrefix_jsGenerator: transpiler [
	<pharoJsSkip>
	^ 'return ',transpiler pharoJsSelectorPrefix asJSON
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> propertySet: func [

	<javascript: 'return {
		enumerable: false,
		configurable: true,
		writable: true,
		value: func}'>
	
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> registerDnu: aSelector [
	| selector props |
	selector := self makePharoJsSelector: aSelector.
	((Object js_at: #prototype) js_hasOwnProperty: selector) ifFalse: [
		props := self makeDNU: aSelector.
		Object
			js_defineProperty: (Object js_at:#prototype)
			field: selector
			properties: (self propertySet: props)
	].
	^ selector
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> registerDnuForAll: anArray [
	anArray js_forEach: [ : each | self registerDnu: each ]
]

{ #category : #importing }
PjCore class >> require: moduleName [

	<jsAlias: #require>
	<javascript: 'return require(moduleName);'>
	^ globalThis require: moduleName
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> selector: selector arguments: args [
	<jsGenerator: #selector_arguments_jsGenerator:>
]

{ #category : #'doesNotUnderstand support' }
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

{ #category : #'throw support' }
PjCore class >> throwFunction [
	<javascript: 'return function(arg){throw arg}'>
]

{ #category : #'throw support' }
PjCore class >> throwFunctionName [
	^ '$throw$'
]
