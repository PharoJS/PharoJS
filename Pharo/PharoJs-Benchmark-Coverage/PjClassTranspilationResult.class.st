Class {
	#name : 'PjClassTranspilationResult',
	#superclass : 'Object',
	#instVars : [
		'transpiledClass',
		'jsCode',
		'isClassDeclarationFailed',
		'failedMethods'
	],
	#category : 'PharoJs-Benchmark-Coverage',
	#package : 'PharoJs-Benchmark-Coverage'
}

{ #category : 'accessing' }
PjClassTranspilationResult >> addFailingMethod: aMethod [

	failedMethods add: aMethod
]

{ #category : 'initialization' }
PjClassTranspilationResult >> classDeclarationFailed [
	isClassDeclarationFailed := true
]

{ #category : 'accessing' }
PjClassTranspilationResult >> classSelectors [

	^ [transpiledClass selectors] on: Error do: [ #() ]
]

{ #category : 'accessing' }
PjClassTranspilationResult >> failedMethods [

	^ failedMethods 
]

{ #category : 'accessing' }
PjClassTranspilationResult >> failedSelectors [

	^ failedMethods collect: #selector
]

{ #category : 'initialization' }
PjClassTranspilationResult >> initialize [

	super initialize.
	failedMethods := Set new.
	isClassDeclarationFailed := false
]

{ #category : 'testing' }
PjClassTranspilationResult >> isClassDeclarationFailed [

	^ isClassDeclarationFailed
]

{ #category : 'testing' }
PjClassTranspilationResult >> isFailure [
	^self isClassDeclarationFailed or: [ self isMethodTranspilationFailed  ] 
]

{ #category : 'testing' }
PjClassTranspilationResult >> isMethodTranspilationFailed [
	^failedMethods notEmpty
]

{ #category : 'testing' }
PjClassTranspilationResult >> isSuccess [
	^self isFailure not
]

{ #category : 'accessing' }
PjClassTranspilationResult >> jsCode [

	^ jsCode
]

{ #category : 'accessing' }
PjClassTranspilationResult >> jsCode: anObject [

	jsCode := anObject
]

{ #category : 'accessing' }
PjClassTranspilationResult >> successSelectors [

	^ self classSelectors copyWithoutAll: self failedSelectors
]

{ #category : 'accessing' }
PjClassTranspilationResult >> transpiledClass [

	^transpiledClass 
]

{ #category : 'accessing' }
PjClassTranspilationResult >> transpiledClass: aClass [ 
	transpiledClass := aClass
]
