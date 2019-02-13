Class {
	#name : #PjClassExtensionForTest,
	#superclass : #Object,
	#category : #'PharoJsTranspiler-Tests-Support'
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
	^{Object ->#(yourself isArray).
		Boolean ->#(isLiteral eqv:).
		UndefinedObject class -> #(allInstances allInstancesDo: new).
	} asDictionary
]

{ #category : #any }
PjClassExtensionForTest >> instanceMethod [
]

{ #category : #any }
PjClassExtensionForTest >> isLiteral [
	^42
]
