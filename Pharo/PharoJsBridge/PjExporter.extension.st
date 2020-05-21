Extension { #name : #PjExporter }

{ #category : #'*PharoJsBridge' }
PjExporter >> convertToJs: anObject [
		self transpiler enableWriteDnuDuring: [
			^ self transpiler convertToJs: anObject]
]

{ #category : #'*PharoJsBridge' }
PjExporter >> invalidateClass: aClass [
	self transpiler invalidateClass: aClass
]

{ #category : #'*PharoJsBridge' }
PjExporter >> setExtraBindings: aDictionary [
	^ self transpiler setExtraBindings: aDictionary
]
