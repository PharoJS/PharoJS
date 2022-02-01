Class {
	#name : #PhxBridgedDateAndDateAndTimeTests,
	#superclass : #PjBridgeTestCase,
	#category : #'PharoJs-Base-Serialization-Tests'
}

{ #category : #tests }
PhxBridgedDateAndDateAndTimeTests >> testDateAndTimeNowEquivalence [
	| pharoTs jsTsString jsTs |
	pharoTs := DateAndTime now.
	jsTsString := self evalBlock: [ DateAndTime now toISOString ].
	jsTs := DateAndTime fromString: jsTsString.
	self assert: (pharoTs asSeconds - jsTs asSeconds) abs < 10.
	self assert: (pharoTs asUTC asSeconds - jsTs asSeconds) abs < 10
]

{ #category : #tests }
PhxBridgedDateAndDateAndTimeTests >> testDateAndTimePhxJsonAlwaysUTC [
	| jsTs phxJson pharoTs pharoTs2 |
	pharoTs := PhxJsonReader
		readFromString: '{"class":"DateAndTime","instance":"2020-04-21T21:17:08.908+02:00"}'.
	self assert: pharoTs offset = 2 hours.
	pharoTs2 := PhxJsonReader readFromString: pharoTs asPhxJsonString.
	self assert: pharoTs2 offset isZero.
	phxJson := self
		evalBlock: [ | ts |
			ts := PhxJsonReader
				readFromString: '{"class":"DateAndTime","instance":"2020-04-21T21:17:08.908+02:00"}'.
			console log: ts.
			ts asPhxJsonString	"always translates to UTC" ].
	jsTs := PhxJsonReader readFromString: phxJson.
	self assert: jsTs offset isZero
]
