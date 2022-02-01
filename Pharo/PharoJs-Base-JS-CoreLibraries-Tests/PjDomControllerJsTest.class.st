Class {
	#name : #PjDomControllerJsTest,
	#superclass : #PjDomControllerPharoTest,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Controllers'
}

{ #category : #accessing }
PjDomControllerJsTest >> appClassToExport [
	^self appClass
]

{ #category : #accessing }
PjDomControllerJsTest >> currentApp [
	| jsMessage |
	jsMessage := PjJavascriptMessage receiverId: self appClass name selector: #currentInstance arguments: #().
	^self bridge evalMessage: jsMessage
]
