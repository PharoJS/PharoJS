Class {
	#name : #PjNumberTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsCoreLibrariesTest-Objects'
}

{ #category : #tests }
PjNumberTest >> testLoops [
	self assertEquivalent: [ | x | x:=0. 1 to: 10 do: [: n | x := x + n ]. x ].
	self assertEquivalent: [ | x | x:=0. 0.034 to: 0.34 do: [: n | x := x + n ]. x ].
	self assertEquivalent: [ | x | x:=0. 0.034 to: 0.34 by: 0.04 do: [: n | x := x + n ]. x ].
	self assertEquivalent: [ | x | x:=0. 0 to: 0.12937879500535276 by: 0.025 do: [: n | x := x + n ]. x ].
	self assertEquivalent: [ | x | x:=0. 10 to: 1 by: -1 do: [: n | x := x + n ]. x ].

]
