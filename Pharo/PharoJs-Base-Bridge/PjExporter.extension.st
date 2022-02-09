Extension { #name : #PjExporter }

{ #category : #'*PharoJs-Base-Bridge' }
PjExporter >> convertToJs: anObject [

	self transpiler enableWriteDnuDuring: [ 
		^ self transpiler convertToJs: anObject ]
]

{ #category : #'*PharoJs-Base-Bridge' }
PjExporter >> invalidateClass: aClass [

	self transpiler invalidateClass: aClass
]

{ #category : #'*PharoJs-Base-Bridge' }
PjExporter >> setExtraBindings: aDictionary [

	^ self transpiler setExtraBindings: aDictionary
]
