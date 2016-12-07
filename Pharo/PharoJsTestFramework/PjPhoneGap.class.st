Class {
	#name : #PjPhoneGap,
	#superclass : #PjPlatform,
	#category : #'PharoJsTestFramework-Platforms'
}

{ #category : #running }
PjPhoneGap >> commandStringWith: aFileReference [ 
	^'open ', (self pathString: aFileReference parent / self startScriptName), ' -g ' "-g == background"
]

{ #category : #running }
PjPhoneGap >> startScriptName [
	self subclassResponsibility
]
