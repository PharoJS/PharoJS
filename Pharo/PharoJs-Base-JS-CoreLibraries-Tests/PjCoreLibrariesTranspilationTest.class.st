Class {
	#name : #PjCoreLibrariesTranspilationTest,
	#superclass : #PjTranspilationClassCompilationTest,
	#category : #'PharoJs-Base-JS-CoreLibraries-Tests-Collections'
}

{ #category : #tests }
PjCoreLibrariesTranspilationTest >> testPjClassWithSerializedSlot [

	self jsCode:
		(self convertClass: PjDummyTestObjectWithSeleriazedClassVar). jsCode
			halt
]

{ #category : #tests }
PjCoreLibrariesTranspilationTest >> testPjStringClass [
	self jsCode: (self convertClass: PjString).
	self assertInstanceMethod: #= equals: '(other){return this==other}'.
	self assertInstanceMethod: #, equals:  '(other){return this+other}'.
]

{ #category : #tests }
PjCoreLibrariesTranspilationTest >> testPjUndefinedObjectClass [
	self jsCode: (self convertClass: PjUndefinedObject).
	self assertInstanceMethod: #= equals:  '(other){return null==other}'.
	self assertClassMethod: #new equals: '(){return Smalltalk._signal_("cannot create instances of UndefinedObject")}'.
	self assertClassMethod: #javascriptInitialize equals: '(){var $1;this.uniqueInstance=this._basicNew();$1=$asNil$(Object);$1.freeze(this.uniqueInstance);$1.freeze(this);return this}'

]
