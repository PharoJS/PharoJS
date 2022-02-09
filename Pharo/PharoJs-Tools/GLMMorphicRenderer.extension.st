Extension { #name : #GLMMorphicRenderer }

{ #category : #'*PharoJs-Tools-Playground' }
GLMMorphicRenderer >> pjRenderOn: aPharoScriptPresentation [
	^ PjMorphicRenderer render: aPharoScriptPresentation from: self
]
