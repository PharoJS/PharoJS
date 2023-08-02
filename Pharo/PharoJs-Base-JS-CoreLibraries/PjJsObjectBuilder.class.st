"
I am designed to simulate object creation on JavaScript using the `{}` notation.
I am used by `asJsObject` message.
Example
```
{
  #name -> 'John'.
  #age -> 42.
  #favoritePlaces -> #('Toronto'. 'Douai').
} asJsObject
```

"
Class {
	#name : #PjJsObjectBuilder,
	#superclass : #Object,
	#instVars : [
		'convertedObjects'
	],
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #converting }
PjJsObjectBuilder class >> convert: anObject [
	^self new convert: anObject
]

{ #category : #converting }
PjJsObjectBuilder >> convert: anObject [
	| jsObject |
	convertedObjects at: anObject ifPresent: [: cachedJsObject | ^cachedJsObject].
	jsObject := anObject asJsObjectUsing: self.
	convertedObjects at: anObject put: jsObject.
	^jsObject
]

{ #category : #'initialize-release' }
PjJsObjectBuilder >> initialize [
	super initialize.
	convertedObjects := Dictionary new
]
