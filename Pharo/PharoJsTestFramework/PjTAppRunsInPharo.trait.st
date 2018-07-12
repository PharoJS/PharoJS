Trait {
	#name : #PjTAppRunsInPharo,
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #testing }
PjTAppRunsInPharo >> appClassToExport [
	^PjAppWrapperForRunningInPharo on: self appClass
]

{ #category : #testing }
PjTAppRunsInPharo >> currentApp [
	^self appClass
		start; 
		currentInstance.

]
