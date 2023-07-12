Trait {
	#name : #PjTWebServerApiTestCase,
	#instVars : [
		'rootUrlString'
	],
	#category : #'PharoJs-TestFramework-Kernel'
}

{ #category : #tests }
PjTWebServerApiTestCase >> get: pathString [

	^ ZnEasy get: self rootUrlString , pathString
]

{ #category : #tests }
PjTWebServerApiTestCase >> port [
	^self app port
]

{ #category : #tests }
PjTWebServerApiTestCase >> post: pathString text: aString [

	^ ZnEasy
		  post: self rootUrlString , pathString
		  data: (ZnEntity text: aString)
]

{ #category : #tests }
PjTWebServerApiTestCase >> rootUrlString [

	^rootUrlString ifNil: [rootUrlString := 'http://localhost:' , self port asString]
]
