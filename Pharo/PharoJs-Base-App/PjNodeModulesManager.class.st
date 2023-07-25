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
PjNodeModulesManager class >> require: aString [

	^ self default require: aString
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
PjNodeModulesManager >> require: aString [

	^ modulesDict
		  at: aString asSymbol
		  ifAbsentPut: [ Smalltalk require: aString ]
]
