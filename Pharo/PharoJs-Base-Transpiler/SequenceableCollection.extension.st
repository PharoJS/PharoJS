Extension { #name : #SequenceableCollection }

{ #category : #'*PharoJs-Base-Transpiler' }
SequenceableCollection >> includes: seq1 before: seq2 [
	| firstIndex |
	firstIndex := self indexOfSubCollection: seq1 startingAt: 1 ifAbsent: [^ false].
	self indexOfSubCollection: seq2 startingAt: firstIndex ifAbsent: [ ^ false].
	^ true
]

{ #category : #'*PharoJs-Base-Transpiler' }
SequenceableCollection >> isFreeJavascriptValue [
	^ self allSatisfy: #isFreeJavascriptValue
]

{ #category : #'*PharoJs-Base-Transpiler' }
SequenceableCollection >> isLiteralJavascriptValue [
	^ self allSatisfy: #isLiteralJavascriptValue
]

{ #category : #'*PharoJs-Base-Transpiler' }
SequenceableCollection >> printJsOn: aStream [
	aStream nextPut: $[.
	self
		do: [ : each |
			each printJsOn: aStream ]
		separatedBy: [
			aStream nextPut: $, ].
	aStream nextPut: $].
]
