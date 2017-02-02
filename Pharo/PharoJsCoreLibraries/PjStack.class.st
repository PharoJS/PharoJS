Class {
	#name : #PjStack,
	#superclass : #Array,
	#type : #variable,
	#pools : [
		'PjUniversalGlobals'
	],
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #accessing }
PjStack >> top [
	^self last
]
