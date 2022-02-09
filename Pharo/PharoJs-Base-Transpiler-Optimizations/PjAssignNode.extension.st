Extension { #name : #PjAssignNode }

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjAssignNode >> constantOrZero [
	^ expression constantOrZero
]
