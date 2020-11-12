Extension { #name : #PjArray }

{ #category : #'*PharoJsSerialization' }
PjArray >> writePhxJsonRepresentationOn: w [
	w
		doBetweenSquareBrackets: [ self
				do: [ :each | each writePhxJsonOn: w ]
				separatedBy: [ w comma ] ]
]
