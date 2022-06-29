Extension { #name : #LocalVariable }

{ #category : #'*PharoJs-Base-Transpiler' }
LocalVariable >> valueStartAtContext: aContext [
	| variableContext |
	variableContext := aContext forScope: self scope.
	^variableContext at: self index.

]
