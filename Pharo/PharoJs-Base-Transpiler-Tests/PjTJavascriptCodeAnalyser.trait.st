"
I have code to support various tests that need to extract values from generated Javascript code.
"
Trait {
	#name : #PjTJavascriptCodeAnalyser,
	#traits : 'PjTStreamWriter',
	#classTraits : 'PjTStreamWriter classTrait',
	#category : #'PharoJs-Base-Transpiler-Tests-Tests'
}

{ #category : #asserting }
PjTJavascriptCodeAnalyser >> assert: actualString includes: expectedSubString [
	self assert: (self does: actualString includes: expectedSubString)
]

{ #category : #asserting }
PjTJavascriptCodeAnalyser >> assert: firstString precedes: secondString [
	| first second |
	first := self jsCode findString: firstString.
	second := self jsCode findString: secondString.
	self assert: first<second
]

{ #category : #asserting }
PjTJavascriptCodeAnalyser >> assertClassMethod: method equals: aString [
	self assert: (self classMethod: method) equals: aString
]

{ #category : #asserting }
PjTJavascriptCodeAnalyser >> assertHasClassMethod: selector [
	self deny: (self classMethod: selector ) isNil
]

{ #category : #asserting }
PjTJavascriptCodeAnalyser >> assertHasInstanceMethod: selector [
	self deny: (self instanceMethod: selector ) isNil
]

{ #category : #asserting }
PjTJavascriptCodeAnalyser >> assertInstanceMethod: method equals: aString [
	self assert: (self instanceMethod: method) equals: aString
]

{ #category : #'test support' }
PjTJavascriptCodeAnalyser >> classMethod: aSymbol [

	^ self method: aSymbol prefix: 'static '
]

{ #category : #accessing }
PjTJavascriptCodeAnalyser >> classToTranspile [
	self explicitRequirement
]

{ #category : #asserting }
PjTJavascriptCodeAnalyser >> deny: actualString includes: expectedSubString [
	self deny: (self does: actualString includes: expectedSubString)
]

{ #category : #asserting }
PjTJavascriptCodeAnalyser >> does: actualString includes: expectedSubString [
	^actualString withSeparatorsCompacted trim includesSubstring: expectedSubString withSeparatorsCompacted trim
]

{ #category : #'test support' }
PjTJavascriptCodeAnalyser >> instanceMethod: aSymbol [

	^ self method: aSymbol prefix: ''
]

{ #category : #accessing }
PjTJavascriptCodeAnalyser >> jsCode [
	self explicitRequirement
]

{ #category : #'test support' }
PjTJavascriptCodeAnalyser >> method: aSymbol prefix: prefixString [

	| start aString end |
	aString := String streamContents: [ :aStream | 
		           aStream
			           << self lineEnding;
			           << prefixString.
		           self writeJsSelector: aSymbol onStream: aStream.
		           aStream << $( ].
	start := self jsCode findString: aString.
	start = 0 ifTrue: [ ^ nil ].
	end := self jsCode
		       findString: (String with: self lineEnding)
		       startingAt: start + 1.
	end = 0 ifTrue: [ end := self jsCode size + 1 ].
	^ self jsCode copyFrom: start + aString size -1 to: end - 1
]
