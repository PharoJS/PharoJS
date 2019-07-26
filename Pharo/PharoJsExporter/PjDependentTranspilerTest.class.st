Class {
	#name : #PjDependentTranspilerTest,
	#superclass : #PjPackageTranspilationTest,
	#category : #'PharoJsExporter-Tests'
}

{ #category : #testing }
PjDependentTranspilerTest >> testBootstrapClasses [
	transpiler alreadyConvertedClasses: { PjCore }.
	self generateJsCodeForClasses: PjExporter bootstrapClasses..
	self assert: PjObject protoSetBefore: PjString.
	self assert: PjObject protoSetBefore: PjError.

]

{ #category : #testing }
PjDependentTranspilerTest >> testClassOrdering [
	transpiler alreadyConvertedClasses: { PjCore. Object. }.
	self generateJsCodeForClasses: {
		PjAlternateClassForTranspilationTest.
	}.
	self assert: PjSuperClassForTranspilationTest protoSetBefore: PjAlternateClassForTranspilationTest.
	self assert: PjSharedPoolForTest protoSetBefore: PjSuperClassForTranspilationTest.
	self assert: PjClassEForPackageTranspilationTest protoSetBefore: PjAlternateClassForTranspilationTest.
	self assert: PjSharedPoolForTest initializedBefore: PjAlternateClassForTranspilationTest.

]

{ #category : #testing }
PjDependentTranspilerTest >> testIncludeMethods [
	self generateJsCodeForClasses: { PjClassForTranspilationTest }.
	self assert: (self instanceMethod: #selector) equals: '(){return this.selector}'.
	self assert: (self instanceMethod: #selectors) equals: '(){return [this.selector]}'.
	self assert: (self instanceMethod: #order:selector:) equals: '(aNumber,aString){this.', PjTranspiler pharoJsSelectorPrefix, 'order_(aNumber);this.selector=aString;return this}'.
	self assert: (self classMethod: #javascriptInitialize) equals: '(){return this}'.
	self assert: (self classMethod: #javascriptName) equals: nil. "because of pragma"
	self assert: (self classMethod: #exampleForTest) equals: '(){return this}'.

]

{ #category : #accessing }
PjDependentTranspilerTest >> transpilerClass [
	^ PjDependentTranspiler
]
