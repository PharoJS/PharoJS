Extension { #name : #GLMMorphicRenderer }

{ #category : #'*PharoJsTools-Playground' }
GLMMorphicRenderer >> pjRenderOn: aPharoScriptPresentation [
	^ PjMorphicRenderer render: aPharoScriptPresentation from: self
]
