"
I am the implementation for Class and Behavior.

I am a subclass of Javascript Function with appropriate methods for Class and Behavior.
"
Class {
	#name : 'PjClass',
	#superclass : 'PjFunction',
	#category : 'PharoJs-Base-JS-CoreLibraries-Kernel',
	#package : 'PharoJs-Base-JS-CoreLibraries',
	#tag : 'Kernel'
}

{ #category : 'as yet unclassified' }
PjClass class >> classPool_jsGenerator: transpiler [

	<pharoJsSkip>
	^ 'return this.' , transpiler classVarsPoolName
]

{ #category : 'Behavior: reflection' }
PjClass class >> hasClassMethod_jsGenerator: transpiler [
	<pharoJsSkip>
	^'return this.__proto__.hasOwnProperty(Smalltalk.', transpiler pharoJsSelectorPrefix, 'makePharoJsSelector_(aSymbol))'
]

{ #category : 'pharoJs support' }
PjClass class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{
		Behavior -> #( subclassesDo: allSubclasses allSubclassesDo: isBehavior includesBehavior: ).
		Class -> #( isClass classVarNames).
	}
]

{ #category : 'Behaviour: object creatioin' }
PjClass >> adoptInstance: anObject [
	anObject js_at: #__proto__ put: (self js_at:#prototype)
" here so that ordinary Javascript 'classes' will respond to the message"
]

{ #category : 'Behavior: reflection' }
PjClass >> class [
	^ PjCore metaclassOf: self
]

{ #category : 'accessing' }
PjClass >> classPool [
	<jsGenerator: #classPool_jsGenerator:>
	
]

{ #category : 'Behavior: reflection' }
PjClass >> classVarNamed: aString [
	^ self classPool at: aString
]

{ #category : 'Behavior: reflection' }
PjClass >> classVarNamed: aString put: otherString [
	self classPool at: aString put: otherString
]

{ #category : 'Behavior: reflection' }
PjClass >> hasClassMethod: aSymbol [
	<jsGenerator: #hasClassMethod_jsGenerator:>
]

{ #category : 'testing' }
PjClass >> identityHash [
	^ (self instVarNamed: #_js_hash) ifNil: [
		self instVarNamed: #_js_hash putHidden: self nextIdentityHash ]
]

{ #category : 'testing' }
PjClass >> isBlock [
	^ false
]

{ #category : 'testing' }
PjClass >> isClass [
	^ true
]

{ #category : 'accessing' }
PjClass >> name [
	<javascript:
	'var s=this.name||this.prototype.toString();
	if (s.substr(0,1)=="[") s=s.substr(8,s.length-9);
	return s'>
]

{ #category : 'Behaviour: object creatioin' }
PjClass >> newFromJsonString: jsonString [
	| newInstance |
	newInstance := JSON js_parse: jsonString.
	self adoptInstance: newInstance.
	^newInstance
" here so that ordinary Javascript 'classes' will respond to the message"
]

{ #category : 'printing' }
PjClass >> printOn: aStream [

	aStream nextPutAll: self name
]

{ #category : 'Behavior: reflection' }
PjClass >> prototype [
	^ self js_at: #prototype
]

{ #category : 'Behavior: reflection' }
PjClass >> subclasses [
	^ subclasses
]

{ #category : 'Behavior: reflection' }
PjClass >> theMetaClass [
	^ self class
]

{ #category : 'Behavior: reflection' }
PjClass >> theNonMetaClass [
	^ self
]
