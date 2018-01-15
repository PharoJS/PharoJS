Class {
	#name : #PjReflectionTest,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJsBridgeTest-Tests'
}

{ #category : #testing }
PjReflectionTest >> testClassName [
	| class |
	class := classFactory
		silentlyNewSubclassOf: PjObject
		instanceVariableNames: 'x y'
		classVariableNames: ''.
	self bridge loadClass: class.
	self assert: [ class name ] evaluatesTo: class name asString.
	self assert: [ class new className ] evaluatesTo: class name asString
]

{ #category : #testing }
PjReflectionTest >> testNestedRepeats [
	| class tryNestedRepeatsSelector tryNestedRepeatsMethod |
	class := classFactory
		silentlyNewSubclassOf: PjObject
		instanceVariableNames: 'x y'
		classVariableNames: ''.
	tryNestedRepeatsSelector := #tryNestedRepeats.
	tryNestedRepeatsMethod := self class
		compiledMethodAt: tryNestedRepeatsSelector.
	class methodDict
		at: tryNestedRepeatsSelector
		put: tryNestedRepeatsMethod.
	self bridge loadClass: class.
	self
		assert: [ class new tryNestedRepeats ]
		evaluatesTo: self tryNestedRepeats
]

{ #category : #testing }
PjReflectionTest >> testReflection [
	self assertEquivalent: [Number inheritsFrom: Object].
	self assertEquivalent: [Number canUnderstand: #isNil].
	self assertEquivalent: [Number canUnderstand: #someSelectorThatDoesntExist].
	self assertEquivalent: [Number canUnderstand: #ifTrue:].
	self assertEquivalent: [42 respondsTo: #ifTrue:].
	self assertEquivalent: [42 respondsTo: #abs].
	self assertEquivalent: [true respondsTo: #ifTrue:].
	self assertEquivalent: [Object new respondsTo: #neverDefined].
	self assert: [ document respondsTo: #neverDefined ] evaluatesTo: false.
	self assertEquivalent: [3 isKindOf: Number].
	self assertEquivalent: [3 isKindOf: Object].
	self assertEquivalent: [3 isMemberOf: SmallInteger].
	self assertEquivalent: [3 isMemberOf: Object].
	self assertEquivalent: [true respondsTo: #not].
	self assertEquivalent: [true respondsTo: #ifTrue:].
	self assertEquivalent: [42 respondsTo: #<=].

]

{ #category : #testing }
PjReflectionTest >> testTemporaries [
	| class tryTemporariesSelector tryTemporariesMethod |
	class := classFactory
		silentlyNewSubclassOf: PjObject
		instanceVariableNames: 'x y'
		classVariableNames: ''.
	tryTemporariesSelector := #tryTemporaries.
	tryTemporariesMethod := self class
		compiledMethodAt: tryTemporariesSelector.
	class methodDict at: tryTemporariesSelector put: tryTemporariesMethod.
	self bridge loadClass: class.
	self
		assert: [ class new tryTemporaries ]
		evaluatesTo: self tryTemporaries
]

{ #category : #'test support' }
PjReflectionTest >> tryNestedRepeats [
		| x |
		x := 1.
		5 timesRepeat: [| w |
			w := w ifNil: [ x ].
			10 timesRepeat: [
				x := x + 1].
			x := x + w].
		^ x
]

{ #category : #'test support' }
PjReflectionTest >> tryTemporaries [ 
		| x b |
		b := [ : a | | y |
			11 timesRepeat: [ | w |
				w := (w ifNil: [ 0 ])+(a*100).
				y := (y ifNil: [ 0 ])+w.
			].
			b isNil ifFalse: [ | z |
				z := (z ifNil: [ 0 ])+a.
				y := (y ifNil: [ 0 ])+(a*10).
				x := (x ifNil: [ 0 ])+(a*100000)+y+z]].
		b value: 1.
		b value: 4.
		^ x
]
