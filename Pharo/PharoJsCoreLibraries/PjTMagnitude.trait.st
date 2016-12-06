"
I am the Magnitude trait.

Because Magnitude cannot be inserted between Number and Object in the Javascript world, I have all the pieces that are needed by both PjMagnitude and PjNumber.
"
Trait {
	#name : #PjTMagnitude,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjTMagnitude classSide >> jsTranspilationImportMethodsMagnitude [
	<pharoJsSkip>
	^ {Magnitude -> #(
				min: max: min:max: between:and: 
				compareWith:ifLesser:ifEqual:ifGreater: 
				> <= >=
			).
		}
]

{ #category : #testing }
PjTMagnitude >> < aMagnitude [
	^self explicitRequirement
]

{ #category : #testing }
PjTMagnitude >> = aMagnitude [
	^self explicitRequirement
]
