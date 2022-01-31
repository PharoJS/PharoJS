Class {
	#name : #PjPackageTranspilationTest,
	#superclass : #PjTranspilationClassCompilationTest,
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #testing }
PjPackageTranspilationTest >> assert: firstClass classVariablesSetBefore: lastClass [
	self 
		assert: firstClass 
		inCodeWith: '.$$def(' 
		before: lastClass
]

{ #category : #testing }
PjPackageTranspilationTest >> assert: firstClass inCodeWith: codeString before: lastClass [
	| firstIndex lastIndex |
	firstIndex := self jsCode indexOfSubCollection: firstClass nameToUseForJsConversion, codeString.
	self deny: firstIndex = 0.
	lastIndex := self jsCode indexOfSubCollection: lastClass nameToUseForJsConversion, codeString.
	self assert: firstIndex < lastIndex.
]

{ #category : #testing }
PjPackageTranspilationTest >> assert: firstClass inCodeWithPrefix: codeString before: lastClass [
	| firstIndex lastIndex |
	firstIndex := self jsCode indexOfSubCollection: codeString, firstClass nameToUseForJsConversion.
	self deny: firstIndex = 0.
	lastIndex := self jsCode indexOfSubCollection: codeString, lastClass nameToUseForJsConversion.
	self assert: firstIndex < lastIndex.
]

{ #category : #testing }
PjPackageTranspilationTest >> assert: firstClass initializedBefore: lastClass [
	self assert: firstClass inCodeWith: '._initialize();' before: lastClass.
]

{ #category : #testing }
PjPackageTranspilationTest >> assert: firstClass protoSetBefore: lastClass [
	self assert: firstClass inCodeWithPrefix: '._subclass_("' before: lastClass.
]

{ #category : #testing }
PjPackageTranspilationTest >> testCircularClass [
	self generateJsCodeForClasses: {
	PjClassBForCircularTranspilationTest.
	}.
	self deny: self jsCode includes: '.prototype.__proto__ = '
]

{ #category : #testing }
PjPackageTranspilationTest >> testClientClassUsesJavascriptNameOfReferencedClass [
	self generateJsCodeForClasses: {
	PjClassBForReferenceTranspilationTest.
	PjClassAForReferenceTranspilationTest.
	}.
	self assert: self jsCode includes: PjClassAForReferenceTranspilationTest javascriptName.
	self deny: self jsCode includes: PjClassAForReferenceTranspilationTest name.
]

{ #category : #testing }
PjPackageTranspilationTest >> testDnuSetup [
	self generateJsCodeForClasses: {
	PjClassBForCircularTranspilationTest.
	}.
	self assert: self jsCode includes: '._registerDnuForAll_(["isNil","javascriptName"]);'
]

{ #category : #testing }
PjPackageTranspilationTest >> testDuplicateClasses [
	| classesToConvert classDefintionString className classInitializationString|
	classesToConvert := OrderedCollection new.
	3 timesRepeat: [ classesToConvert add: PjClassAForPackageTranspilationTest].
	self generateJsCodeForClasses: classesToConvert.
	className := PjClassAForPackageTranspilationTest name.
	classDefintionString := 'subclass_("', className,'")'.
	classInitializationString := className, '._initialize();'.
	{classDefintionString. classInitializationString} do: [:each |
		self assert: (jsCode allRangesOfSubstring: each) size equals: 1] .
]

{ #category : #testing }
PjPackageTranspilationTest >> testJavascriptInitializeOverridesClassInitialize [
	self generateJsCodeForClasses: {
	PjClientForJavascriptInitializationTest.
	PjProviderForInitializationTest
	}.
	self assert: self jsCode includes: PjClientForJavascriptInitializationTest name, '._javascriptInitialize()'.
	self deny: self jsCode includes: PjClientForJavascriptInitializationTest name, '._initialize()'.
	self 
		assert: PjProviderForInitializationTest name, '._initialize()'
		appearsBefore: PjClientForJavascriptInitializationTest name, '._javascriptInitialize()'
]

{ #category : #testing }
PjPackageTranspilationTest >> testProviderInitializedBeforeClient [
	self generateJsCodeForClasses: {
	PjClassCForPackageTranspilationTest.
	PjClassBForPackageTranspilationTest.
	PjClassAForPackageTranspilationTest.
	}.
	self assert: PjClassBForPackageTranspilationTest initializedBefore: PjClassCForPackageTranspilationTest.
]

{ #category : #testing }
PjPackageTranspilationTest >> testProviderInitializedBeforeClientSubclass [
	self generateJsCodeForClasses: {
	PjClassEForPackageTranspilationTest.
	PjClassDForPackageTranspilationTest.
	PjClassBForPackageTranspilationTest.
	PjClassAForPackageTranspilationTest.
	}.
	self assert: PjClassBForPackageTranspilationTest initializedBefore: PjClassEForPackageTranspilationTest.
]

{ #category : #testing }
PjPackageTranspilationTest >> testSuperclassClassVariablesSetBeforeSubclass [
	self generateJsCodeForClasses: {
	PjClassBForPackageTranspilationTest.
	PjClassAForPackageTranspilationTest.
	}.
	self assert: PjClassAForPackageTranspilationTest classVariablesSetBefore: PjClassBForPackageTranspilationTest.
]

{ #category : #testing }
PjPackageTranspilationTest >> testSuperclassInitializedBeforeSubclass [
	self generateJsCodeForClasses: {
	PjClassBForPackageTranspilationTest.
	PjClassAForPackageTranspilationTest.
	}.
	self assert: PjClassAForPackageTranspilationTest initializedBefore: PjClassBForPackageTranspilationTest.
]

{ #category : #testing }
PjPackageTranspilationTest >> testSuperclassProtoSetBeforeSubclass [
	self generateJsCodeForClasses: {
	PjClassBForPackageTranspilationTest.
	PjClassAForPackageTranspilationTest.
	}.
	self assert: PjClassAForPackageTranspilationTest protoSetBefore: PjClassBForPackageTranspilationTest.
]
