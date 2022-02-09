"
A class used in tests with some concrete methods originally defined as ""subclass responsiblity"" in one of the superclasses. This is used to verify that the class is seen as non-abstract (concrete) class and returning false for #isAbstract without having an explicit implementation of an own #isAbstract method.

"
Class {
	#name : #PjToolsTestClass2b,
	#superclass : #PjToolsTestClass1,
	#category : #'PharoJs-Tools-Tests-Data'
}

{ #category : #'concrete sample methods' }
PjToolsTestClass2b >> m1 [
	^ #m1
]

{ #category : #'concrete sample methods' }
PjToolsTestClass2b >> m2 [
	^ #m2
]
