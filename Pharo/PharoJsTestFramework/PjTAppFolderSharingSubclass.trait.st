"
This trait is useful when defining a hierarchy of classes that rely on the same HTML and related files (CSS, third party JS, ...). The JS is exported in the same folder as its superclass.

This is useful for example for  test purpose. A subclass  can be defined for enabling tests using mocks,
Another use is when defining variants of  the  same app, typically for experiment purpose.
"
Trait {
	#name : #PjTAppFolderSharingSubclass,
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #exporting }
PjTAppFolderSharingSubclass classSide >> appFolder [
	<pharoJsSkip>
	^self superclass appFolder

]
