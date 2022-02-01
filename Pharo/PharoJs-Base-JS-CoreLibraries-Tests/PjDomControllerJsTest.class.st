Class {
	#name : #PjDomControllerJsTest,
	#superclass : #PjDomControllerPharoTest,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Controllers'
}

{ #category : #testing }
PjDomControllerJsTest >> appClassToExport [
	^self appClass
]

{ #category : #testing }
PjDomControllerJsTest >> currentApp [
	| jsMessage |
	jsMessage := PjJavascriptMessage receiverId: self appClass name selector: #currentInstance arguments: #().
	^self bridge evalMessage: jsMessage
]
