Trait {
	#name : #PjTAppSubclassForTest,
	#category : #'PharoJsTestFramework-Kernel'
}

{ #category : #exporting }
PjTAppSubclassForTest classSide >> appFolder [
	<pharoJsSkip>
	^self superclass appFolder

]
