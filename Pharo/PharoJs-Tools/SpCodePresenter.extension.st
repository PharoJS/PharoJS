Extension { #name : #SpCodePresenter }

{ #category : #'*PharoJs-Tools' }
SpCodePresenter >> addBinding: aVariable [

	"Used by PharoJS Playground to add instances of WorkspaceVariable "

	self interactionModel addBinding: aVariable
]
