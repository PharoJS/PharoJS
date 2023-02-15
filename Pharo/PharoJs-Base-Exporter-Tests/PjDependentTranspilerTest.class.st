Class {
	#name : #PjDependentTranspilerTest,
	#superclass : #PjPackageTranspilationTest,
	#category : #'PharoJs-Base-Exporter-Tests-Tests'
}

{ #category : #testing }
PjDependentTranspilerTest >> testBootstrapClasses [

	transpiler alreadyConvertedClasses: { PjCore }.
	self generateJsCodeForClasses: PjExporter bootstrapClasses.
	self assertClassExtension: PjObject installedBefore: PjString.
	self assertClassExtension: PjObject installedBefore: PjError
]

{ #category : #testing }
PjDependentTranspilerTest >> testClassOrdering [
	transpiler alreadyConvertedClasses: { PjCore. Object. }.
	self generateJsCodeForClasses: {
		PjAlternateClassForTranspilationTest.
	}.
	self assertClass: PjSuperClassForTranspilationTest installedBefore: PjAlternateClassForTranspilationTest.
	self assertClass: PjSharedPoolForTest installedBefore: PjSuperClassForTranspilationTest.
	self assertClass: PjClassEForPackageTranspilationTest installedBefore: PjAlternateClassForTranspilationTest.
	self assert: PjSharedPoolForTest initializedBefore: PjAlternateClassForTranspilationTest.
]

{ #category : #testing }
PjDependentTranspilerTest >> testIncludeMethods [
	" test that methods from a variety of dependent classes get loaded "
	self generateJsCodeForClasses: { PjClassForTranspilationTest }.
	self assert: (self instanceMethod: #selector) equals: '(){return this.selector}'.
	self assert: (self instanceMethod: #selectors) equals: '(){return [this.selector]}'.
	self assert: (self instanceMethod: #order:selector:) equals: '(aNumber,aString){this._order_(aNumber);this.selector=aString;return this}'.
	self assert: (self classMethod: #javascriptName) equals: nil. "because of pragma"
	self assert: (self classMethod: #exampleForTest) equals: '(){return this}'.
]

{ #category : #accessing }
PjDependentTranspilerTest >> transpilerClass [
	^ PjDependentTranspiler
]
