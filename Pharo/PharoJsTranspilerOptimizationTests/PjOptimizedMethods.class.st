"
Sample methods for PjOptimizedMethodTest
"
Class {
	#name : #PjOptimizedMethods,
	#superclass : #Object,
	#category : #'PharoJsTranspilerOptimizationTests-Support'
}

{ #category : #asserting }
PjOptimizedMethods >> shouldReturnTrue [
    false
        ifTrue: [ 1 ifNil: [  ] ]
        ifFalse: [ 1 ifNil: [  ].
            ^ true ].
    ^ false
]

{ #category : #asserting }
PjOptimizedMethods >> shouldReturnTrue2 [
    false
        ifTrue: [ 1 ifNil: [  ] ]
        ifFalse: [ 1 ifNotNil: [ ^ true ].
            ^ true ].
    ^ false
]
