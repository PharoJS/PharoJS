Class {
	#name : #PjNodeModulesManager,
	#superclass : #Object,
	#instVars : [
		'modulesDict'
	],
	#classInstVars : [
		'default'
	],
	#category : #'PharoJs-Base-App'
}

{ #category : #accessing }
PjNodeModulesManager class >> default [
	^default ifNil: [ default := self new ]
]

{ #category : #accessing }
PjNodeModulesManager class >> moduleNamed: aString [
	^self default moduleNamed: aString

]

{ #category : #accessing }
PjNodeModulesManager class >> resetDefault [

	default := nil
]

{ #category : #initialization }
PjNodeModulesManager >> initialize [ 
	super initialize .
	modulesDict := Dictionary new
]

{ #category : #accessing }
PjNodeModulesManager >> moduleNamed: aString [

	^ modulesDict
		  at: aString asSymbol
		  ifAbsentPut: [ self require: aString ]
]

{ #category : #accessing }
PjNodeModulesManager >> require: moduleName [

	^ Smalltalk require: moduleName
]
