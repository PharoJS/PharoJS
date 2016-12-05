Extension { #name : #PjLiteralValueNode }

{ #category : #'*PharoJsTranspilerOptimization' }
PjLiteralValueNode >> constantOrZero [
	value isNumber ifFalse: [ ^ 0 ].
	^ value
]

{ #category : #'*PharoJsTranspilerOptimization' }
PjLiteralValueNode >> isLiteralFalse [
	^ value = false
]

{ #category : #'*PharoJsTranspilerOptimization' }
PjLiteralValueNode >> isLiteralTrue [
	^ value = true
]

{ #category : #'*PharoJsTranspilerOptimization' }
PjLiteralValueNode >> target [
	^ self
]
