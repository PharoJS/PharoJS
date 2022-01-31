Class {
	#name : #PjPrimitiveTranspilationTest,
	#superclass : #PjTranspilationClassCompilationTest,
	#category : #'PharoJsTranspilerTests-Tests'
}

{ #category : #testing }
PjPrimitiveTranspilationTest >> testPrimitiveFailing [
	self should: [
		self generateJsCodeForClasses: {
			PjClassForPrimitiveFailingTest.
		}
	] raise: PjJavascriptTranspilationError description: 'fail for primitive'
]

{ #category : #testing }
PjPrimitiveTranspilationTest >> testPrimitiveWithFallback [
	self generateJsCodeForClasses: {
		PjClassForPrimitiveTest.
	}.
	self assertInstanceMethod: #+ equals: '(aNumber){return $asNil$(aNumber)._adaptToFloat_andSend_(this,"+")}'
]
