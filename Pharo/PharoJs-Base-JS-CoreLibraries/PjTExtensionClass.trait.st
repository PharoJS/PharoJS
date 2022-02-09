"
An extension class is a class that provides methods to augment a javascript constructor, and thus provide primitive operations from the Pharo world.

The convention is to name extension classes after the javascript constructor, prefixed by 'Pj'.
"
Trait {
	#name : #PjTExtensionClass,
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjTExtensionClass classSide >> javascriptName [
	<pharoJsSkip>
	^ (self name allButFirst: 2) asSymbol
]
