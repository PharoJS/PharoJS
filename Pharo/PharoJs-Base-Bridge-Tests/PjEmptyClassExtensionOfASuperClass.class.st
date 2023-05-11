Class {
	#name : #PjEmptyClassExtensionOfASuperClass,
	#superclass : #Object,
	#category : #'PharoJs-Base-Bridge-Tests-Support'
}

{ #category : #'pharoJs support' }
PjEmptyClassExtensionOfASuperClass class >> isJsClassPlaceholder [

	<pharoJsSkip>
	^ true
]

{ #category : #'pharoJs support' }
PjEmptyClassExtensionOfASuperClass class >> javascriptName [

	<pharoJsSkip>
	^ PjASuperClass name
]
