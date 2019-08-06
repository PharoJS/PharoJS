"
It is important to have the behavior at the class side because the transpiler relies on the AST global node for classes.
"
Class {
	#name : #PjAppWrapperForRunningInPharo,
	#superclass : #Object,
	#classInstVars : [
		'currentAppClass'
	],
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #description }
PjAppWrapperForRunningInPharo class >> appClass [
	<pharoJsSkip>
	^self
]

{ #category : #description }
PjAppWrapperForRunningInPharo class >> appClasses [
	<pharoJsSkip>
	^currentAppClass appClasses copyWithout: currentAppClass.
]

{ #category : #description }
PjAppWrapperForRunningInPharo class >> appLaunchBlock [
	<pharoJsSkip>
	^[]
]

{ #category : #description }
PjAppWrapperForRunningInPharo class >> appPackages [
	<pharoJsSkip>
	^#()
]

{ #category : #'bridge handling' }
PjAppWrapperForRunningInPharo class >> bridge [
	<pharoJsSkip>
	^ PjBridge bridgeForAppClass: self

]

{ #category : #'reflective operations' }
PjAppWrapperForRunningInPharo class >> doesNotUnderstand: aMessage [
	<pharoJsSkip>
	^aMessage sendTo: currentAppClass
]

{ #category : #'bridge handling' }
PjAppWrapperForRunningInPharo class >> newBridgeClient [
	<pharoJsSkip>
	^self bridgeClientClass appClass: self
]

{ #category : #'initialize - release' }
PjAppWrapperForRunningInPharo class >> on: appClass [
	<pharoJsSkip>
	currentAppClass := appClass
]

{ #category : #'start-stop' }
PjAppWrapperForRunningInPharo class >> start [
	^self
]

{ #category : #'start-stop' }
PjAppWrapperForRunningInPharo class >> stop [
	^self
]
