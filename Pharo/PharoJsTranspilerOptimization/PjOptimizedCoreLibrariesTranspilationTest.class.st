Class {
	#name : #PjOptimizedCoreLibrariesTranspilationTest,
	#superclass : #PjTranspilationClassCompilationTest,
	#category : #'PharoJsTranspilerOptimization-Tests'
}

{ #category : #running }
PjOptimizedCoreLibrariesTranspilationTest >> setUp [
	super setUp.
	transpiler addAllOptionalConversions
]

{ #category : #testing }
PjOptimizedCoreLibrariesTranspilationTest >> testPjLoggingEvaluatorWebSocketDelegateClass [
	|prefix|
	prefix := transpiler pharoJsSelectorPrefix.
	self jsCode: (self convertClass: PjLoggingEvaluatorWebsocketDelegate).
	self assertInstanceMethod: #log: equals: '(aString){var logElement,br,text,$_self_$=this;(function(){var $1;br=$asNil$(document).', prefix,'createElement_("BR");text=$asNil$(document).', prefix,'createTextNode_(aString);logElement=$_self_$.', prefix,'logElement();return ($1=$asNil$(logElement),$1.', prefix,'insertBefore_node_(br,$asNil$(logElement).', prefix,'firstChild()),$1.', prefix,'insertBefore_node_(text,$asNil$(logElement).', prefix,'firstChild()))}).', prefix,'on_do_(Error,function(){return $asNil$(console).', prefix,'log_(aString)});return this}'
]

{ #category : #testing }
PjOptimizedCoreLibrariesTranspilationTest >> testPjStringClass [
	|prefix|
	prefix := transpiler pharoJsSelectorPrefix.
	self jsCode: (self convertClass: PjString).
self assertInstanceMethod: #isLetter equals: '(){return $asNil$(this.', prefix,'letterCharCodes()).', prefix,'includes_(this.charCodeAt(0))}'

]
