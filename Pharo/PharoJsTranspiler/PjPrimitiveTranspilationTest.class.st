Class {
	#name : #PjPrimitiveTranspilationTest,
	#superclass : #PjTranspilationClassCompilationTest,
	#category : #'PharoJsTranspiler-Tests'
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
	self assertInstanceMethod: #+ equals: '(aNumber){return $asNil$(aNumber).pj_adaptToFloat_andSend_(this,"+")}'
]
