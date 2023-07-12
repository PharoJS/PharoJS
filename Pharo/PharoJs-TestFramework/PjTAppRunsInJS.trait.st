"
This trait makes a test case export the app under test to JS and control it remotely on the JS interpreter.


"
Trait {
	#name : #PjTAppRunsInJS,
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #accessing }
PjTAppRunsInJS >> appClassToExport [
	^self appClass
]

{ #category : #accessing }
PjTAppRunsInJS >> currentApp [

	^ self bridge
		  evalSelector: #currentInstance
		  sentTo: self appClass name
]
