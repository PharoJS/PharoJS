"
I have utility methods for testing transpiled code
"
Class {
	#name : #PjTranspilationClassCompilationTest,
	#superclass : #PjTranspilationTest,
	#instVars : [
		'jsCode'
	],
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #checking }
PjTranspilationClassCompilationTest >> assert: codeString1 appearsBefore: codeString2 [
	self assert: (self jsCode includes: codeString1 before: codeString2 )
]

{ #category : #checking }
PjTranspilationClassCompilationTest >> assert: aString includes: mName then: mString [
	| pName pString pEnd |
	pName := aString findString: mName startingAt: 1.
	self assert: pName>0.
	pString := aString findString: mString startingAt: pName.
	self assert: pString > pName.
	pEnd := aString findString: '}' startingAt: pName.
	self assert: pString < pEnd.
]

{ #category : #checking }
PjTranspilationClassCompilationTest >> convertAllClasses: classes [
	^transpiler convertAllClasses: classes;jsCode
]

{ #category : #checking }
PjTranspilationClassCompilationTest >> generateJsCodeForClasses: classes [
	self classToTranspile: classes last.
	self jsCode: (self convertAllClasses: classes)
]

{ #category : #accessing }
PjTranspilationClassCompilationTest >> jsCode [
	^ jsCode
]

{ #category : #accessing }
PjTranspilationClassCompilationTest >> jsCode: anObject [
	jsCode := anObject trim
]
