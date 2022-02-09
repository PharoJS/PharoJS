Extension { #name : #PjCollection }

{ #category : #'*PharoJs-Base-Serialization' }
PjCollection >> writePhxJsonRepresentationOn: w [
	w
		doBetweenSquareBrackets: [ self
				do: [ :each | each writePhxJsonOn: w ]
				separatedBy: [ w comma ] ]
]
