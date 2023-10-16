Class {
	#name : #PjCoverageTranspiler,
	#superclass : #PjTranspiler,
	#instVars : [
		'result'
	],
	#category : #'PharoJs-Benchmark-Coverage'
}

{ #category : #'transpiling classes' }
PjCoverageTranspiler >> convertClass: aClass [

	result := PjClassTranspilationResult new transpiledClass: aClass.
	[ super convertClass: aClass ]
		on: Error
		do: [ result classDeclarationFailed ].
	result jsCode: self jsCode.
	^result
]

{ #category : #'transpiling methods' }
PjCoverageTranspiler >> transpileMethod: aMethod [

	[ super transpileMethod: aMethod ]
		on: Error
		do: [
			result addFailingMethod: aMethod ]
]

{ #category : #'transpiling classes' }
PjCoverageTranspiler >> writeClassDefinitionOf: aClass [

	result := PjClassTranspilationResult new transpiledClass: aClass.
	[ super writeClassDefinitionOf: aClass ]
		on: Error
		do: [ result classDeclarationFailed ].
	result jsCode: self jsCode.
	^ result
]
