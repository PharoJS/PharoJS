"
I have utility methods for testing transpiled code
"
Class {
	#name : #PjTranspilationClassCompilationTest,
	#superclass : #PjTranspilationTest,
	#instVars : [
		'jsCode'
	],
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #testing }
PjTranspilationClassCompilationTest >> assert: codeString1 appearsBefore: codeString2 [
	self assert: (self jsCode includes: codeString1 before: codeString2 )

]

{ #category : #testing }
PjTranspilationClassCompilationTest >> convertAllClasses: classes [
	^transpiler convertAllClasses: classes;jsCode
]

{ #category : #testing }
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
