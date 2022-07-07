Extension { #name : #LocalVariable }

{ #category : #'*PharoJs-Base-Transpiler' }
LocalVariable >> valueStartAtContext: aContext [

	| variableContext  |
	(aContext tempNames includes: self name) ifTrue: [ ^aContext tempNamed: self name].
	variableContext := aContext forScope: self scope.
	^ self readFromContext: variableContext scope: self scope
]
