Extension { #name : #PjArray }

{ #category : #'*PharoJs-Base-Serialization' }
PjArray >> writePhxJsonRepresentationOn: w [
	w
		doBetweenSquareBrackets: [ self
				do: [ :each | each writePhxJsonOn: w ]
				separatedBy: [ w comma ] ]
]
