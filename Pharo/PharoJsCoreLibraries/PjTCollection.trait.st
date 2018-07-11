"
I am the Collection trait.

Because Collection cannot be inserted between Array and Object in the Javascript world, I have all the pieces that are needed by both PjCollection and PjArray.
"
Trait {
	#name : #PjTCollection,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharojs support' }
PjTCollection classSide >> jsTranspilationImportMethodsCollection [
	<pharoJsSkip>
	^ {
		Collection ->#(asSet reject: asOrderedCollection
			allSatisfy: anySatisfy: noneSatisfy: inject:into: 
			detect:ifFound:ifNone: detect:ifNone: detect:ifFound: remove: isCollection 
			asDictionary associationsDo: addAll: isEmptyOrNil removeAll: 
		).
		Collection class ->#(
			withAll: 
		).
		OrderedCollection class -> #( newFrom: ).
	}
]

{ #category : #testing }
PjTCollection >> = aMagnitude [
	^self explicitRequirement
]

{ #category : #random }
PjTCollection >> atRandom [
	<javascript: 'var randomIndex = Math.floor((Math.random() * this._size()) + 1);
	return this._at_(randomIndex);'>
]
