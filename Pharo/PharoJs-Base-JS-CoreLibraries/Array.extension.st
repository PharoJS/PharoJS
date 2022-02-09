Extension { #name : #Array }

{ #category : #'*PharoJs-Base-JS-CoreLibraries-converting' }
Array >> asJsObjectUsing: converter [
	"This method is used only in the Pharo world. In JS, we use instead PjTArray>>#asJsObject"
	(self notEmpty and: [(self first isKindOf: Association) not]) ifTrue: [ 
		^self
	].
	^self asDictionary asJsObjectUsing: converter
]

{ #category : #'*PharoJs-Base-JS-CoreLibraries' }
Array class >> javascriptPlaceholder [
	^ PjArray
]
