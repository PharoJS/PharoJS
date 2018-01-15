Trait {
	#name : #PjTAppRunsInPharo,
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #testing }
PjTAppRunsInPharo >> currentApp [
	^self appClass
		start; 
		currentInstance.

]
