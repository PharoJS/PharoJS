Extension { #name : #Dictionary }

{ #category : #'*PharoJsSerialization' }
Dictionary >> writePhxJsonRepresentationOn: w [
	w
		doBetweenCurlyBraces: [ self keys
				do:
					[ :key | w writeKeyName: key andValue: [ (self at: key) writePhxJsonOn: w ] ]
				separatedBy: [ w comma ] ]
]
