"
I am the implementation for Class and Behavior.

I am a subclass of Javascript Function with appropriate methods for Class and Behavior.
"
Class {
	#name : #PjClassInJS,
	#superclass : #PjFunction,
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'as yet unclassified' }
PjClassInJS class >> classPool_jsGenerator: transpiler [

	<pharoJsSkip>
	^ 'return this.' , transpiler classVarsPoolName
]

{ #category : #'Behavior: reflection' }
PjClassInJS class >> hasClassMethod_jsGenerator: transpiler [
	<pharoJsSkip>
	^'return this.__proto__.hasOwnProperty(Smalltalk.', transpiler pharoJsSelectorPrefix, 'makePharoJsSelector_(aSymbol))'
]

{ #category : #'pharoJs support' }
PjClassInJS class >> javascriptName [

	<pharoJsSkip>
	^ #PjClass
]

{ #category : #'pharoJs support' }
PjClassInJS class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{
		Behavior -> #( subclassesDo: allSubclasses allSubclassesDo: isBehavior ).
		Class -> #( isClass classVarNames).
	}
]

{ #category : #'Behaviour: object creatioin' }
PjClassInJS >> adoptInstance: anObject [
	anObject js_at: #__proto__ put: (self js_at:#prototype)
" here so that ordinary Javascript 'classes' will respond to the message"
]

{ #category : #'Behavior: reflection' }
PjClassInJS >> class [
	^ PjCore metaclassOf: self
]

{ #category : #accessing }
PjClassInJS >> classPool [
	<jsGenerator: #classPool_jsGenerator:>
	
]

{ #category : #'Behavior: reflection' }
PjClassInJS >> classVarNamed: aString [
	^ self classPool at: aString
]

{ #category : #'Behavior: reflection' }
PjClassInJS >> classVarNamed: aString put: otherString [
	self classPool at: aString put: otherString
]

{ #category : #'Behavior: reflection' }
PjClassInJS >> hasClassMethod: aSymbol [
	<jsGenerator: #hasClassMethod_jsGenerator:>
]

{ #category : #testing }
PjClassInJS >> isBlock [
	^ false
]

{ #category : #testing }
PjClassInJS >> isClass [
	^ true
]

{ #category : #accessing }
PjClassInJS >> name [
	<javascript:
	'var s=this.name||this.prototype.toString();
	if (s.substr(0,1)=="[") s=s.substr(8,s.length-9);
	return s'>
]

{ #category : #'Behaviour: object creatioin' }
PjClassInJS >> newFromJsonString: jsonString [
	| newInstance |
	newInstance := JSON js_parse: jsonString.
	self adoptInstance: newInstance.
	^newInstance
" here so that ordinary Javascript 'classes' will respond to the message"
]

{ #category : #printing }
PjClassInJS >> printOn: aStream [

	aStream nextPutAll: self name
]

{ #category : #'Behavior: reflection' }
PjClassInJS >> prototype [
	^ self js_at: #prototype
]

{ #category : #'Behavior: reflection' }
PjClassInJS >> subclasses [
	^ subclasses
]

{ #category : #'Behavior: reflection' }
PjClassInJS >> theMetaClass [
	^ self class
]

{ #category : #'Behavior: reflection' }
PjClassInJS >> theNonMetaClass [
	^ self
]
