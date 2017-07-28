Class {
	#name : #PjNumberForDuration,
	#superclass : #Object,
	#traits : 'PjTExtensionClass',
	#classTraits : 'PjTExtensionClass classTrait',
	#category : #'PharoJsCoreLibraries-Chronology'
}

{ #category : #'pharoJs support' }
PjNumberForDuration class >> javascriptName [
	<pharoJsSkip>
	^ #Number
]

{ #category : #'pharoJs support' }
PjNumberForDuration class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	| instanceSelectors |
	instanceSelectors := 
		#(year years week weeks day days hour hours minute minutes second seconds milliSecond milliSeconds),
		(Number selectorsInProtocol: '*PharoExtra-Chronology').
	^{Number -> instanceSelectors.
	Number class-> #(one)}
]
