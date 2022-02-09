Trait {
	#name : #PjTPharoJsForSeaside,
	#category : #'PharoJs-Base-JS-Seaside'
}

{ #category : #hooks }
PjTPharoJsForSeaside classSide >> generateScript [
	|newScript exporter |
	exporter := PjExporter exporterForApp: self pharoJsAppClass.
	newScript := exporter javascriptCode.
	self scriptCache: newScript.
	^newScript
]

{ #category : #hooks }
PjTPharoJsForSeaside classSide >> pharoJsAppClass [
	self explicitRequirement
]

{ #category : #hooks }
PjTPharoJsForSeaside classSide >> resetScriptCache [
	self scriptCache: nil
]

{ #category : #hooks }
PjTPharoJsForSeaside classSide >> script [
	^self scriptCache ifNil: [self generateScript]

]

{ #category : #hooks }
PjTPharoJsForSeaside classSide >> scriptCache [
	self explicitRequirement
]

{ #category : #hooks }
PjTPharoJsForSeaside classSide >> scriptCache: jsCode [
	self explicitRequirement
]

{ #category : #hooks }
PjTPharoJsForSeaside >> resetScriptCache [
	self class resetScriptCache
]

{ #category : #hooks }
PjTPharoJsForSeaside >> script [
	^self class script
]
