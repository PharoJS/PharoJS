"
Placeholder class for `OrderedCollection`
"
Class {
	#name : 'PjOrderedCollection',
	#superclass : 'PjArray',
	#category : 'PharoJs-Base-JS-CoreLibraries-Kernel',
	#package : 'PharoJs-Base-JS-CoreLibraries',
	#tag : 'Kernel'
}

{ #category : 'pharoJs support' }
PjOrderedCollection class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^{OrderedCollection -> #( join: addAllLast: addAllFirst: speciesForTransform).
	(OrderedCollection class -> #( newFrom: ))}

]

{ #category : 'instance creation' }
PjOrderedCollection class >> new: ignored [
	^ self new

]
