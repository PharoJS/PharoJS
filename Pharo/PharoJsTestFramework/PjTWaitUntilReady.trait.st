Trait {
	#name : #PjTWaitUntilReady,
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #waiting }
PjTWaitUntilReady >> defaultTimeOutActionBlock [
	^[ self fail ]
]

{ #category : #waiting }
PjTWaitUntilReady >> defaultWaitTimeOutDuration [ 
	^2 seconds
]

{ #category : #waiting }
PjTWaitUntilReady >> stepDuration [
	^50 milliSeconds
]

{ #category : #waiting }
PjTWaitUntilReady >> waitUntil: conditionBlock [
	self waitUntil: conditionBlock timeOut: self defaultWaitTimeOutDuration 
]

{ #category : #waiting }
PjTWaitUntilReady >> waitUntil: conditionBlock timeOut: maxToWait [ 
	self
		waitUntil: conditionBlock 
		timeOut: maxToWait 
		ifTimeOutDo: self defaultTimeOutActionBlock
]

{ #category : #waiting }
PjTWaitUntilReady >> waitUntil: conditionBlock timeOut: maxToWait ifTimeOutDo: timeOutBlock [
	self
		waitWhile: [conditionBlock value not] 
		timeOut: maxToWait 
		ifTimeOutDo: timeOutBlock
]

{ #category : #waiting }
PjTWaitUntilReady >> waitWhile: conditionBlock [
	self waitWhile: conditionBlock timeOut: self defaultWaitTimeOutDuration 
]

{ #category : #waiting }
PjTWaitUntilReady >> waitWhile: conditionBlock timeOut: maxToWait [ 
	self
		waitWhile: conditionBlock 
		timeOut: maxToWait 
		ifTimeOutDo: self defaultTimeOutActionBlock
]

{ #category : #waiting }
PjTWaitUntilReady >> waitWhile: conditionBlock timeOut: maxToWait ifTimeOutDo: timeOutBlock [
	| totalWaited |
	totalWaited := 0 second.
	[totalWaited < maxToWait and: conditionBlock] whileTrue: [
		self stepDuration wait.
		totalWaited := totalWaited + self stepDuration].
	totalWaited >= maxToWait ifTrue: timeOutBlock
]
