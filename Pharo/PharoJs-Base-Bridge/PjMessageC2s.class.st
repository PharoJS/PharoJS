Class {
	#name : #PjMessageC2s,
	#superclass : #PjMessage,
	#category : #'PharoJs-Base-Bridge-Messages'
}

{ #category : #public }
PjMessageC2s >> evaluateInContext: aMessageContext [
	"self subclassResponsibility "
]

{ #category : #accessing }
PjMessageC2s >> inResponseToId [
	^nil
]

{ #category : #testing }
PjMessageC2s >> isCallback [
	^ false
]

{ #category : #testing }
PjMessageC2s >> shouldEvaluateImmediately [
	^false
]
