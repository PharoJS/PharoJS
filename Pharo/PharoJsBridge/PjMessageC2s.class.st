Class {
	#name : #PjMessageC2s,
	#superclass : #PjMessage,
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #public }
PjMessageC2s >> evaluateInContext: aMessageContext [
	"self subclassResponsibility "
]

{ #category : #testing }
PjMessageC2s >> isCallback [
	^ false
]

{ #category : #testing }
PjMessageC2s >> shouldEvaluateImmediately [
	^false
]
