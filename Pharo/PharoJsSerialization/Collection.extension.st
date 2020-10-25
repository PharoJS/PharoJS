Extension { #name : #Collection }

{ #category : #'*PharoJsSerialization' }
Collection >> writePhxJsonRepresentationOn: w [
	w
		doBetweenSquareBrackets: [ self
				do: [ :each | each writePhxJsonOn: w ]
				separatedBy: [ w comma ] ]
]
