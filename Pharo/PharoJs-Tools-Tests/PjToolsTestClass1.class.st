"
A class used in tests with some ""subclass responsibility"" methods defined as an indirect subclass of PjApplication. This is used to verify that the class is seen as abstract class without having to explicitly declare #isAbstract.
"
Class {
	#name : #PjToolsTestClass1,
	#superclass : #PjWebApplication,
	#category : #'PharoJs-Tools-Tests-Data'
}

{ #category : #accessing }
PjToolsTestClass1 class >> bridgeClientClass [
	^ nil
]

{ #category : #accessing }
PjToolsTestClass1 class >> c1 [
	^ self subclassResponsibility
]

{ #category : #'abstract sample methods' }
PjToolsTestClass1 >> m1 [
	^ self subclassResponsibility
]

{ #category : #'abstract sample methods' }
PjToolsTestClass1 >> m2 [
	^ self subclassResponsibility
]

{ #category : #'abstract sample methods' }
PjToolsTestClass1 >> m3 [
	^ 18
]
