"
I am the implementation for Class and Behavior.

I am a subclass of Javascript Function with appropriate methods for Class and Behavior.
"
Class {
	#name : #PjClass,
	#superclass : #PjFunction,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjClass class >> javascriptName [
	<pharoJsSkip>
	^self name
]

{ #category : #'pharoJs support' }
PjClass class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{
		Behavior -> #( inheritsFrom: subclassesDo: allSubclassesDo: isBehavior ).
		Class -> #( isClass ).
	}
]

{ #category : #'Behaviour: object creatioin' }
PjClass >> adoptInstance: anObject [
	anObject js_at: #__proto__ put: (self js_at:#prototype)
" here so that ordinary Javascript 'classes' will respond to the message"
]

{ #category : #'Behavior: reflection' }
PjClass >> canUnderstand: selector [
	| jsSelector |
	jsSelector := PjCore makeJavascriptSelector: selector.
	^ (self prototype js_at: jsSelector) ifNil: [ false ] ifNotNil: [: selct | '__DNU' ~= (selct js_at: #name)]
]

{ #category : #'Behavior: reflection' }
PjClass >> class [
	^ PjCore metaclassOf: self
]

{ #category : #testing }
PjClass >> isBlock [
	^ false
]

{ #category : #testing }
PjClass >> isClass [
	^ true
]

{ #category : #accessing }
PjClass >> name [
	<javascript:
	'var s=this.name||this.prototype.toString();
	if (s.substr(0,1)=="[") s=s.substr(8,s.length-9);
	return s'>
]

{ #category : #'Behaviour: object creatioin' }
PjClass >> newFromJsonString: jsonString [
	| newInstance |
	newInstance := JSON js_parse: jsonString.
	self adoptInstance: newInstance.
	^newInstance
" here so that ordinary Javascript 'classes' will respond to the message"
]

{ #category : #'Behavior: reflection' }
PjClass >> prototype [
	^ self js_at: #prototype
]

{ #category : #'Behavior: reflection' }
PjClass >> subclasses [
	^ subclasses
]

{ #category : #'Behavior: reflection' }
PjClass >> superclass [
	self == Object ifTrue: [ ^nil ].
	^((self js_at: #prototype) js_at: #__proto__) class
]

{ #category : #'Behavior: reflection' }
PjClass >> theMetaClass [
	^ self class
]

{ #category : #'Behavior: reflection' }
PjClass >> theNonMetaClass [
	^ self
]
