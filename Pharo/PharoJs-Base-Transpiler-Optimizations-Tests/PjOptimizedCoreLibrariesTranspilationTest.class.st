Class {
	#name : #PjOptimizedCoreLibrariesTranspilationTest,
	#superclass : #PjTranspilationClassCompilationTest,
	#category : #'PharoJs-Base-Transpiler-Optimizations-Tests-Tests'
}

{ #category : #running }
PjOptimizedCoreLibrariesTranspilationTest >> setUp [
	super setUp.
	transpiler addAllOptionalConversions
]

{ #category : #testing }
PjOptimizedCoreLibrariesTranspilationTest >> testPjLoggingEvaluatorWebSocketDelegateClass [
	self jsCode: (self convertClass: PjLoggingEvaluatorWebsocketDelegate).
	self assertInstanceMethod: #log: equals: '(aString){var logElement,br,text,$_self_$=this;(function(){var $1;br=$asNil$(document)._createElement_("BR");text=$asNil$(document)._createTextNode_(aString);logElement=$_self_$._logElement();return ($1=$asNil$(logElement),$1._insertBefore_node_(br,$asNil$(logElement)._firstChild()),$1._insertBefore_node_(text,$asNil$(logElement)._firstChild()))})._on_do_(Error,function(){return $asNil$(console)._log_(aString)});return this}'
]

{ #category : #testing }
PjOptimizedCoreLibrariesTranspilationTest >> testPjStringClass [
	self jsCode: (self convertClass: PjString).
self assertInstanceMethod: #isLetter equals: '(){return $asNil$(this._letterCharCodes())._includes_(this.charCodeAt(0))}'
]
