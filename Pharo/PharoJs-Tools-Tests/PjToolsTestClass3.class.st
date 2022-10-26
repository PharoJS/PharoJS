"
A class used in tests with some concrete methods originally defined as ""subclass responsiblity"" in one of the superclasses. This is used to verify that the class is seen as non-abstract (concrete) class and returning false for #isAbstract without having an explicit implementation of an own #isAbstract method.

"
Class {
	#name : #PjToolsTestClass3,
	#superclass : #PjToolsTestClass2,
	#category : #'PharoJs-Tools-Tests-Data'
}

{ #category : #settings }
PjToolsTestClass3 class >> playgroundDoNotList [
	<pharoJsSkip>
]

{ #category : #'concrete sample methods' }
PjToolsTestClass3 >> m2 [
	^ 7
]
