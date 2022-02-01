Extension { #name : #PjArray }

{ #category : #'*PharoJs-Base-Serialization-Deprecated' }
PjArray >> materialize [
	^PjMaterializer materializeFromArray: self
]
