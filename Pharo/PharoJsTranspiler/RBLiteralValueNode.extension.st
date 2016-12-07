Extension { #name : #RBLiteralValueNode }

{ #category : #'*PharoJsTranspiler' }
RBLiteralValueNode >> isLiteralNumberNode [
	^self value isNumber
]
