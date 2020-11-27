Extension { #name : #PjCollection }

{ #category : #'*PharoJsSerialization' }
PjCollection >> writePhxJsonRepresentationOn: w [
	w
		doBetweenSquareBrackets: [ self
				do: [ :each | each writePhxJsonOn: w ]
				separatedBy: [ w comma ] ]
]
