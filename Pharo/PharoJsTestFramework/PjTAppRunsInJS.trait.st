Trait {
	#name : #PjTAppRunsInJS,
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #testing }
PjTAppRunsInJS >> appClassToExport [
	^self appClass
]

{ #category : #testing }
PjTAppRunsInJS >> currentApp [
	| jsMessage |
	jsMessage := PjJavascriptMessage receiverId: self appClass name selector: #currentInstance arguments: #().
	^self bridge evalMessage: jsMessage

]
