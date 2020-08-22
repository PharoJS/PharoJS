Extension { #name : #ScaledDecimal }

{ #category : #'*PharoJsSerialization' }
ScaledDecimal >> writePhxJsonOn: w [
	w << (self printShowingDecimalPlaces: self scale)
]
