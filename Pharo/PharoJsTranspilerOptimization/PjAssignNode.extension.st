Extension { #name : #PjAssignNode }

{ #category : #'*PharoJsTranspilerOptimization' }
PjAssignNode >> constantOrZero [
	^ expression constantOrZero
]
