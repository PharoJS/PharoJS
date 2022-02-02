"
A class used in tests with some ""subclass responsibility"" methods defined as a subclass of another subclass with ""subclass responsibility"" methods. This is used to verify that the class is seen as abstract class without having an explicit implementation of an own #isAbstract method.

"
Class {
	#name : #PjToolsTestClass2,
	#superclass : #PjToolsTestClass1,
	#category : #'PharoJs-Tools-Tests-Data'
}

{ #category : #accessing }
PjToolsTestClass2 class >> c1 [
	^ 12
]

{ #category : #'abstract sample methods' }
PjToolsTestClass2 >> m1 [
	^ 4
]
