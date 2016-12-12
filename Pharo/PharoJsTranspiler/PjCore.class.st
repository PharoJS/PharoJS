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
		'metaclassClass'
	],
	#category : #'PharoJsTranspiler-Globals'
}

{ #category : #accessing }
PjCore class >> emptyJavascriptObject [
	"Object.create(null) creates an even emptier JS object, but it isn't an Object (i.e. has no methods)."
	<javascript: '
		return {}
	'>
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> handleDNU: aMessage for: anObject [
	" this could be a smalltalk object or a native JS object "
	| selector type |
	selector := (aMessage selector js_split: ':') js_at: 0.
	type := selector js_split: '_'.
	^ self
			installDNU: type
			arguments: aMessage arguments
			selector: selector
			js: (self makeJavascriptSelector: aMessage selector)
			for: anObject
			else: [
				self error: 'Message not understood: ',anObject className,'>>#',aMessage selector
	]
]

{ #category : #'nil support' }
PjCore class >> initNilInJs [
	" specifically install in the global space, rather than in the Smalltalk global space "
	global js_at: self nilTestFunctionName put: (self nilIfUndefined)
]

{ #category : #'reflection support' }
PjCore class >> initObject [
	(Object js_at: #__proto__) js_at: #_subclass_ put: self makeSubclass.
	((self js_at: #theClassClass) js_at: #prototype) js_at: #__proto__
		put: (BlockClosure js_at: #prototype).

]

{ #category : #'throw support' }
PjCore class >> initThrowInJs [
	" specifically install in the global space, rather than in the Smalltalk global space "
	global js_at: self throwFunctionName put: (self throwFunction)
]

{ #category : #initalize }
PjCore class >> initializeCore [
	selectorCache := self emptyJavascriptObject.
	self initNilInJs.
	self initThrowInJs.
	self initObject.
	self messageClass: self.
	self metaclassClass: self.

]

{ #category : #globals }
PjCore class >> install: anObject asGlobalNamed: jsName [
	"Install an object in the Smalltalk global space.
	For now, we use the JS global, but this is likely to evolve once we have environments."
	global js_at: jsName put: anObject
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> installDNU: aType arguments: args selector: selector js: jsSelector for: anObject else: aBlock [
	" this could be a smalltalk object or a native JS object "
	| type  func |
	type := aType.
	(0 ~= type and: [
		1 ~= type and: [
			2 ~= type and: [
				(type := anObject js_at: selector) notNil]]]) ifTrue: [
		type typeof = 'function' ifTrue: [
			type := 2
		] ifFalse: [
			type := args js_at: #length
	]].
	0 = type ifTrue: [
		func := self makeGetter: selector.
		(Object js_defineProperty: (anObject js_at:'__proto__')
				field: jsSelector
				properties: (self propertySet: func)).
		^ func js_call: anObject
	].
	1 = type ifTrue: [
		func := self makeSetter: selector.
		(Object js_defineProperty: (anObject js_at:'__proto__')
				field: jsSelector
				properties: (self propertySet: func)).
		^ func js_call: anObject with: (args js_at: 0) ].
	2 <= type ifTrue: [
		type := anObject.
		[ type notNil ] whileTrue: [
			((type js_hasOwnProperty: selector) and: [
				(type js_at: selector) typeof = 'function' ]) ifTrue: [
				func := type js_at: selector.
				(Object js_defineProperty: type
						field: jsSelector
						properties: (self propertySet: func)).
				^ func js_apply: anObject args: args 
			].
			type := type instVarNamed:'__proto__'
	]].
	^ aBlock value
]

{ #category : #accessing }
PjCore class >> javascriptName [
	<pharoJsSkip>
	^ #Smalltalk
]

{ #category : #'reflection support' }
PjCore class >> keys: anObject [
	<javascript: '
	var result={};
	for (var i in anObject) { if(typeof anObject[i]!="function" && anObject[i]!=null && anObject[i]._proxyResponse) result[i]=anObject[i]._proxyResponse()}
	return {_proxyResponse:function(){return {keys:result}}}
	'>
]

{ #category : #logging }
PjCore class >> log: message [
	console js_log: message
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> makeDNU: aSelector [
	<javascript:
	'var pjCore=this;
	return function __DNU() {
		return this._doesNotUnderstand_(
			pjCore._selector_arguments_(pjCore._makeSmalltalkSelector_(aSelector),
										[].slice.call(arguments)))}'>
										" call to slice may prevent optimization of this function
										   but most DNUs will only be called once or twice anyway "
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> makeDnu0: aSelector [
	<javascript:
	'var pjCore=this;
	return function __DNU() {
		return this._doesNotUnderstand_(
			pjCore._selector_arguments_(pjCore._makeSmalltalkSelector_(aSelector),[]))}'>
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> makeDnu1: aSelector [
	<javascript:
	'var pjCore=this;
	return function __DNU(arg1) {
		return this._doesNotUnderstand_(
			pjCore._selector_arguments_(pjCore._makeSmalltalkSelector_(aSelector),[arg1]))}'>
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> makeDnu2: aSelector [
	<javascript:
	'var pjCore=this;
	return function __DNU(arg1,arg2) {
		return this._doesNotUnderstand_(
			pjCore._selector_arguments_(pjCore._makeSmalltalkSelector_(aSelector),[arg1,arg2]))}'>
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> makeDnuN: aSelector [
	<javascript:
	'var pjCore=this;
	return function __DNU() {
		var args=new Array(arguments.length);
			for(var i=0;i<arguments.length;++i) args[i]=arguments[i]
		return this._doesNotUnderstand_(
			pjCore._selector_arguments_(pjCore._makeSmalltalkSelector_(aSelector),args))}'>
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> makeGetter: selector [
	<javascript:
	'return function Getter(){return this[selector]}'>
]

{ #category : #accessing }
PjCore class >> makeJavascriptSelector: aSelector [
	| result |
	(aSelector js_at: 0)='_' ifTrue: [ ^ aSelector ].
	(selectorCache js_at: aSelector) ifNotNil: [ : sel | ^ sel ].
	aSelector ifNotNil: [:sel |
		sel isLetter ifTrue: [
			result := (':',sel) js_split: ':'
		] ifFalse: [
			result := #(nil).
			1 to: sel size do: [: idx |
				result js_push: (sel js_charCodeAt: idx-1) js_toString
			].
			result js_push: nil
		].
		result := result js_join: '_'
	].
	(selectorCache js_at: result) ifNil: [ selectorCache js_at: result put: aSelector ].
	(selectorCache js_at: aSelector) ifNil: [ selectorCache js_at: aSelector put: result ].
	^ result
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> makeSetter: selector [
	<javascript:
	'return function Setter(value){return this[selector]=value}'>
]

{ #category : #accessing }
PjCore class >> makeSmalltalkSelector: aSelector [
	| result |
	(aSelector js_at: 0) = '_' ifFalse: [ ^ aSelector ].
	(selectorCache js_at: aSelector) ifNotNil: [ : sel | ^ sel ].
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

{ #category : #'reflection support' }
PjCore class >> makeSubclass [
	<javascript: '
	var pjCore=this;return function(aClassName){
	var subclass = (function(){
		if(typeof aClassName == "string"){
			if(this[aClassName])return this[aClassName];
			aClassName=(new Function("return function "+aClassName+"(){}"))()}
		if(this[aClassName.name]==aClassName)return aClassName;
		return this[aClassName.name]=aClassName})();
	subclass.subclasses=[];
	if(subclass==this) {
		this.__proto__ = {__proto__ : pjCore.theClassClass.prototype};
	}else{ 
		subclass.__proto__ = {__proto__ : this.__proto__};
		subclass.prototype.__proto__ = this.prototype;
		this.subclasses.push(subclass);
	}}
	'>
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
	<javascript:
	'if(this.metaclassClass!==this) return this.metaclassClass._metaclassOf_(aClass);
	var theMetaClass={ prototype: aClass.__proto__,__proto__:this.theClassClass.prototype,
		_name: function(){return aClass._name()+" class"},
		_theNonMetaClass: function(){return aClass},
		_theMetaClass: function(){return theMetaClass},
		};
	return theMetaClass
	'>
]

{ #category : #'nil support' }
PjCore class >> nilIfUndefined [
	<javascript: 'var pjCore=this;return function(arg){if(arg == undefined){
		return pjCore.nilInJs;
	}
	return arg}'>
]

{ #category : #'nil support' }
PjCore class >> nilInJs: anObject [
	nilInJs := anObject
]

{ #category : #'nil support' }
PjCore class >> nilTestFunctionName [
	^ '$asNil$'
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> propertySet: func [
	<javascript:
	'return {
		enumerable: false,
		configurable: false,
		writable: true,
		value: func}'>
]

{ #category : #'doesNotUnderstand support' }
PjCore class >> registerDnu: aSelector [
	| selector props |
	selector := self makeJavascriptSelector: aSelector.
	((Object js_at:#prototype) js_at: selector) ifNil: [
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

{ #category : #'doesNotUnderstand support' }
PjCore class >> selector: selector arguments: args [
	<javascript:
	'if(this.messageClass!==this)
		return this.messageClass._selector_arguments_(selector,arguments);
	return {
			selector: selector,
			_selector: function(){return this.selector},
			arguments: args,
			_arguments: function(){return this.arguments}
		}'>
]

{ #category : #'reflection support' }
PjCore class >> subclass: aClassName [
	<javascript: '
	var subclass = (function(){
		if(typeof aClassName == "string"){
			if(this[aClassName])return this[aClassName];
			aClassName=(new Function("return function "+aClassName+"(){}"))()}
		if(this[aClassName.name]==aClassName)return aClassName;
		return this[aClassName.name]=aClassName})();
	subclass.__proto__ = {__proto__ : this.__proto__};
	subclass.subclasses=[];
	if(subclass!=this) { 
		subclass.prototype.__proto__ = this.prototype;
		this.subclasses.push(subclass);
	}
	'>
]

{ #category : #'throw support' }
PjCore class >> throwFunction [
	<javascript: 'return function(arg){throw arg}'>
]

{ #category : #'throw support' }
PjCore class >> throwFunctionName [
	^ '$throw$'
]
