"
I am the Collection trait.

Because Collection cannot be inserted between Array and Object in the Javascript world, I have all the pieces that are needed by both PjCollection and PjArray.
"
Trait {
	#name : 'PjTCollection',
	#category : 'PharoJs-Base-JS-CoreLibraries-Kernel',
	#package : 'PharoJs-Base-JS-CoreLibraries',
	#tag : 'Kernel'
}

{ #category : 'random' }
PjTCollection classSide >> atRandom_jsGenerator: transpiler [
	<pharoJsSkip>
	^'var randomIndex = Math.floor((Math.random() * this.', transpiler pharoJsSelectorPrefix, 'size()) + 1);
	return this.', transpiler pharoJsSelectorPrefix, 'at_(randomIndex);'
]

{ #category : 'pharojs support' }
PjTCollection classSide >> jsTranspilationImportMethodsCollection [

	<pharoJsSkip>
	^ {
		  (Collection
		   -> #( asSet reject: asOrderedCollection allSatisfy: anySatisfy:
			      noneSatisfy: #inject:into: #detect:ifFound:ifNone:
			      #detect:ifNone: #detect:ifFound: remove: isCollection
			      asDictionary associationsDo: addAll: isEmptyOrNil
			      removeAll: includesAll: includesAny: copyWith: average
			      sum emptyCheck anyOne min max )).
		  (Collection class -> #( withAll: )) }
]

{ #category : 'testing' }
PjTCollection >> = aMagnitude [
	^self explicitRequirement
]

{ #category : 'random' }
PjTCollection >> atRandom [
	<jsGenerator: #atRandom_jsGenerator:>
]
