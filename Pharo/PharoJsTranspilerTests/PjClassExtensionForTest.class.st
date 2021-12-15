Class {
	#name : #PjClassExtensionForTest,
	#superclass : #Object,
	#category : #'PharoJsTranspilerTests-Support'
}

{ #category : #accessing }
PjClassExtensionForTest class >> exampleForTest [
	^self
]

{ #category : #accessing }
PjClassExtensionForTest class >> javascriptInitialize [
	^self
]

{ #category : #accessing }
PjClassExtensionForTest class >> javascriptName [
	<pharoJsSkip>
	^PjClassForTranspilationTest name
]

{ #category : #importing }
PjClassExtensionForTest class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ { 
		  (Object -> #( yourself isArray )).
			(PjFooClassForTest -> #(foo)).
		  (Boolean -> #( eqv: )).
		  (UndefinedObject class -> #( allInstances allInstancesDo:
		      new )) } asDictionary
]

{ #category : #any }
PjClassExtensionForTest >> foo [

	^ 42
]

{ #category : #any }
PjClassExtensionForTest >> instanceMethod [
]
