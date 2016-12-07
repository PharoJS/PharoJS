"
Provides a class factory and a default class to use in tests.
Both are provided by a resource to avoid creating the default class upon each test run, which is too slow in Pharo 5 (was faster in Pharo 4).
"
Class {
	#name : #PjGeneratedClassTranspilationTest,
	#superclass : #PjTranspilationTest,
	#instVars : [
		'class'
	],
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #accessing }
PjGeneratedClassTranspilationTest class >> resources [
	^{PjClassFactoryTestResource}
]

{ #category : #testing }
PjGeneratedClassTranspilationTest >> assertStCode: methodBodyString convertedIncludes: expectedJsSubstring [
	self assertStMethodCode:  'm\' withCRs, methodBodyString convertedIncludes: expectedJsSubstring.
]

{ #category : #testing }
PjGeneratedClassTranspilationTest >> assertStMethodCode: methodString convertedIncludes: expectedJsSubstring [
	| jsCode |
	class compile: methodString.
	jsCode := self convertClass: class.
	self assert: jsCode includes: expectedJsSubstring.
]

{ #category : #accessing }
PjGeneratedClassTranspilationTest >> classFactory [
	^PjClassFactoryTestResource current classFactory
]

{ #category : #accessing }
PjGeneratedClassTranspilationTest >> defaultClass [
	^PjClassFactoryTestResource current defaultClass
]

{ #category : #testing }
PjGeneratedClassTranspilationTest >> setUp [
	super setUp.
	class := self defaultClass.
]
