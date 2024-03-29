"
A Plan is an ordered list of constraints to be executed in sequence to
resatisfy all currently satisfiable constraints in the face of one or more
changing inputs.
"
Class {
	#name : #PjDbPlan,
	#superclass : #OrderedCollection,
	#type : #variable,
	#category : #'PharoJs-Benchmarking-DeltaBlue'
}

{ #category : #execution }
PjDbPlan >> execute [
	"Execute my constraints in order."

	self do: [: c | c execute].
]
