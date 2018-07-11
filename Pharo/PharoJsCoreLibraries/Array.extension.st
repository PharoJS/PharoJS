Extension { #name : #Array }

{ #category : #'*PharoJsCoreLibraries-converting' }
Array >> asJsObjectUsing: converter [
	"This method is used only in the Pharo world. In JS, we use instead PjTArray>>#asJsObject"
	(self notEmpty and: [(self first isKindOf: Association) not]) ifTrue: [ 
		^self
	].
	^self asDictionary asJsObjectUsing: converter
]

{ #category : #'*PharoJsCoreLibraries' }
Array class >> javascriptPlaceholder [
	^ PjArray
]
