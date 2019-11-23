Extension { #name : #PjArray }

{ #category : #'*PharoJsSerialization' }
PjArray >> materialize [
	^PjMaterializer materializeFromArray: self
]
