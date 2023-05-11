Class {
	#name : #PjExtensionOfBSubClassOfA,
	#superclass : #Object,
	#category : #'PharoJs-Base-Bridge-Tests-Support'
}

{ #category : #'pharoJs support' }
PjExtensionOfBSubClassOfA class >> isJsClassPlaceholder [ 

	<pharoJsSkip>
	^ true
]

{ #category : #'pharoJs support' }
PjExtensionOfBSubClassOfA class >> javascriptName [

	<pharoJsSkip>
	^ PjBSubClassOfA name
]

{ #category : #accessing }
PjExtensionOfBSubClassOfA class >> someString [

	<jsAlias: #someStringAlias>
	^ super someString , ' Answer'
]

{ #category : #accessing }
PjExtensionOfBSubClassOfA >> someNumber [

		<jsAlias: #someNumberAlias>
	^ super someNumber + 2
]
