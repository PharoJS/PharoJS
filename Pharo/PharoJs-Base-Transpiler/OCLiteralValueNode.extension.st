Extension { #name : 'OCLiteralValueNode' }

{ #category : '*PharoJs-Base-Transpiler' }
OCLiteralValueNode >> isLiteralNumberNode [
	^self value isNumber
]
