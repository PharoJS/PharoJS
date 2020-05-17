Extension { #name : #PjArray }

{ #category : #'*PharoJsSerializationDeprecated' }
PjArray >> materialize [
	^PjMaterializer materializeFromArray: self
]
