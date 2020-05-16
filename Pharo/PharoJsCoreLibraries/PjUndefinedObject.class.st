"
I am the implementation for UndefinedObject. Any method calls translate the Javascript values ""undefined"" and ""null"" into my sole instance using the global function $isNil$, so that method dispatch will happen through me.
"
Class {
	#name : #PjUndefinedObject,
	#superclass : #PjObject,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #initialize }
PjUndefinedObject class >> identityHash_jsGenerator: transpiler [
	<pharoJsSkip>
	^'return ', nil identityHash asString
]

{ #category : #initialize }
PjUndefinedObject class >> javascriptInitialize [
	PjCore nilInJs: self basicNew
]

{ #category : #'pharojs support' }
PjUndefinedObject class >> javascriptName [
	<pharoJsSkip>
	^self name
]

{ #category : #'pharoJs support' }
PjUndefinedObject class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{UndefinedObject -> #(
				isNil ifNil: ifNotNil: ifNil:ifNotNil: ifNotNil:ifNil:
				isNotNil notNil isEmptyOrNil 
			).
		}
]

{ #category : #initialize }
PjUndefinedObject class >> new [
	^PjCore signal: 'cannot create instances of UndefinedObject'
]

{ #category : #comparing }
PjUndefinedObject >> = other [
	<javascript: 'return undefined==other'>
]

{ #category : #converting }
PjUndefinedObject >> asJSON [
	^ 'null'
]

{ #category : #comparing }
PjUndefinedObject >> identityHash [
	<jsGenerator: #identityHash_jsGenerator:>
]

{ #category : #accessing }
PjUndefinedObject >> isJSPrimitiveType [
	^ true
]

{ #category : #converting }
PjUndefinedObject >> proxyResponse [
	^ self
]

{ #category : #converting }
PjUndefinedObject >> value [
	^ nil
]
