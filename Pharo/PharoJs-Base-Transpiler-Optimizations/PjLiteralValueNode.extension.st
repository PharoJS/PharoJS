Extension { #name : #PjLiteralValueNode }

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjLiteralValueNode >> constantOrZero [
	value isNumber ifFalse: [ ^ 0 ].
	^ value
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjLiteralValueNode >> isLiteralFalse [
	^ value = false
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjLiteralValueNode >> isLiteralTrue [
	^ value = true
]

{ #category : #'*PharoJs-Base-Transpiler-Optimizations' }
PjLiteralValueNode >> target [
	^ self
]
