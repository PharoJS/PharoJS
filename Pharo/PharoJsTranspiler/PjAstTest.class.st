Class {
	#name : #PjAstTest,
	#superclass : #PjAstTests,
	#category : #'PharoJsTranspiler-Tests'
}

{ #category : #testing }
PjAstTest >> testAstArraySimilarility [
	| astArray1 astArray2 astArray3 astArray4 astArray5 |
	astArray1 := PjArrayNode expressions: { one. two. three }.
	astArray2 := PjArrayNode expressions: { three. two. one }.
	astArray3 := PjArrayNode expressions: { three. one }.
	astArray4 := PjArrayNode expressions: astArray1 expressions, { selfNode }.
	astArray5 := PjArrayNode expressions: { selfNode }, astArray2 expressions.

	{astArray1. astArray2. astArray3} do: [ : astArray |
		self assert: (astArray isSimilarTo: astArray)].
	self assert: (astArray1 isSimilarTo: astArray2).
	self deny: (astArray1 isSimilarTo: astArray3).
	self deny: (astArray2 isSimilarTo: astArray3).
	self deny:  (astArray4 isSimilarTo: astArray5).
	
	
]

{ #category : #testing }
PjAstTest >> testAstMessageSimilarility [
	
	| astArray1 astArray2 astArray3 astCall1 astCall2 astCall3 astCall4 astCall5 |
	astArray1 := PjArrayNode expressions: { one. two. three }.
	astArray2 := PjArrayNode expressions: { three. two. one }.
	astArray3 := PjArrayNode expressions: { three. one }.
	
	astCall1 := PjApplyNode receiver: selfNode selector: #selector1: args: astArray1 expressions.
	astCall2 := PjApplyNode receiver: selfNode selector: #selector1: args: astArray2 expressions.
	astCall3 := PjApplyNode receiver: selfNode selector: #selector2: args: astArray1 expressions.
	astCall4 := PjApplyNode receiver: one selector: #selector1: args: astArray1 expressions.
	astCall5 := PjApplyNode receiver: selfNode selector: #selector1: args: astArray3 expressions.

	{astCall1. astCall2. astCall3. astCall4. astCall5} do: [ :  astCall |
		self assert: (astCall isSimilarTo: astCall)].
	self assert: (astCall1 isSimilarTo: astCall2).
	self deny: (astCall1 isSimilarTo: astCall3).
	self deny: (astCall2 isSimilarTo: astCall3).
	self deny:  (astCall1 isSimilarTo: astCall4).
	self deny:  (astCall1 isSimilarTo: astCall5).
	self deny:  (astCall3 isSimilarTo: astCall4).
	self deny:  (astCall3 isSimilarTo: astCall5).
	self deny:  (astCall4 isSimilarTo: astCall5).
	
	
	
	
]

{ #category : #testing }
PjAstTest >> testAstSelfSimilarility [
	self assert: (selfNode isSimilarTo: PjSelfNode new). "keep the creation"
	self deny: (selfNode isSimilarTo: two).
	self deny: (two isSimilarTo: selfNode).
	
	
]
