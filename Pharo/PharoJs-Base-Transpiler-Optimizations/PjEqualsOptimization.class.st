"
Straight equality comparison doesn't work for arrays, so if we can't show that the left or right values are non-arrays, must fallback to method call.
"
Class {
	#name : #PjEqualsOptimization,
	#superclass : #PjComparisonOptimization,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Optimizations'
}

{ #category : #converting }
PjEqualsOptimization >> isOkWith: receiver and: arg [
	receiver isNonArray ifFalse: [ arg isNonArray ifFalse: [ ^ false ]].
	^ true
]

{ #category : #converting }
PjEqualsOptimization >> operator [
	^ #==
]

{ #category : #accessing }
PjEqualsOptimization >> selector [
	^#=
]
