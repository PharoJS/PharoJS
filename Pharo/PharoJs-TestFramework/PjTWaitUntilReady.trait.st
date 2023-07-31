Trait {
	#name : #PjTWaitUntilReady,
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #waiting }
PjTWaitUntilReady classSide >> waitStepDuration [
	^100 milliSeconds
]

{ #category : #waiting }
PjTWaitUntilReady classSide >> waitTimeoutDuration [ 
	^2 seconds
]

{ #category : #waiting }
PjTWaitUntilReady >> defaultTimeOutActionBlock [
	^[ self fail ]
]

{ #category : #waiting }
PjTWaitUntilReady >> waitStepDuration [
	^ self class waitStepDuration
]

{ #category : #waiting }
PjTWaitUntilReady >> waitTimeoutDuration [
	^ self class waitTimeoutDuration
]

{ #category : #waiting }
PjTWaitUntilReady >> waitUntil: conditionBlock [
	self waitUntil: conditionBlock timeOut: self waitTimeoutDuration
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
	self waitWhile: conditionBlock timeOut: self waitTimeoutDuration
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
		self waitStepDuration wait.
		totalWaited := totalWaited + self waitStepDuration].
	totalWaited >= maxToWait ifTrue: timeOutBlock
]
