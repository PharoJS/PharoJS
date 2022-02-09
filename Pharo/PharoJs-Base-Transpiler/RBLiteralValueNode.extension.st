Extension { #name : #RBLiteralValueNode }

{ #category : #'*PharoJs-Base-Transpiler' }
RBLiteralValueNode >> isLiteralNumberNode [
	^self value isNumber
]
