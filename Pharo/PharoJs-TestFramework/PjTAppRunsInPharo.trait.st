"
This trait makes a test case run the app under test on the Pharo VM. Only third party JS code and DOM objects are run on the JS interpreter

"
Trait {
	#name : #PjTAppRunsInPharo,
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #accessing }
PjTAppRunsInPharo >> appClassToExport [
	^PjAppWrapperForRunningInPharo on: self appClass
]

{ #category : #accessing }
PjTAppRunsInPharo >> currentApp [
	^self appClass
		start; 
		currentInstance.
]
