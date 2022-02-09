Extension { #name : #ScaledDecimal }

{ #category : #'*PharoJs-Base-Serialization' }
ScaledDecimal >> writePhxJsonOn: w [
	w << (self printShowingDecimalPlaces: self scale)
]
