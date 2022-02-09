Extension { #name : #Collection }

{ #category : #'*PharoJs-Base-Serialization' }
Collection >> writePhxJsonRepresentationOn: w [
	w
		doBetweenSquareBrackets: [ self
				do: [ :each | each writePhxJsonOn: w ]
				separatedBy: [ w comma ] ]
]
