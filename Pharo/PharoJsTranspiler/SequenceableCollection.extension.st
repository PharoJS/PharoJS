Extension { #name : #SequenceableCollection }

{ #category : #'*PharoJsTranspiler' }
SequenceableCollection >> includes: seq1 before: seq2 [
	| firstIndex |
	firstIndex := self indexOfSubCollection: seq1 startingAt: 1 ifAbsent: [^ false].
	self indexOfSubCollection: seq2 startingAt: firstIndex ifAbsent: [ ^ false].
	^ true
]

{ #category : #'*PharoJsTranspiler' }
SequenceableCollection >> isFreeJavascriptValue [
	^ self allSatisfy: #isFreeJavascriptValue
]

{ #category : #'*PharoJsTranspiler' }
SequenceableCollection >> isLiteralJavascriptValue [
	^ self allSatisfy: #isLiteralJavascriptValue
]

{ #category : #'*PharoJsTranspiler' }
SequenceableCollection >> printJsOn: aStream [
	aStream nextPut: $[.
	self
		do: [ : each |
			each printJsOn: aStream ]
		separatedBy: [
			aStream nextPut: $, ].
	aStream nextPut: $].
]
