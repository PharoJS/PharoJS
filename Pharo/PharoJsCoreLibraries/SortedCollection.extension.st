Extension { #name : #SortedCollection }

{ #category : #'*PharoJsCoreLibraries' }
SortedCollection >> groupedBy: aBlock [
<pharoJsSkip>
	"Answer a dictionary whose keys are the result of evaluating aBlock for all my elements, and the value for each key is the selection of my elements that evaluated to that key. Uses species."
	| groups |
	groups := OrderedDictionary new.
	self do: [ :each |
		(groups at: (aBlock value: each) ifAbsentPut: [ OrderedCollection new ]) add: each ].
	groups associationsDo: [ :association |
			"need to make sure to create the collection with the same sortblock"
			association value: (self copyEmpty addAll: association value ; yourself) ].
	^ groups
]

{ #category : #'*PharoJsCoreLibraries-Kernel' }
SortedCollection class >> javascriptPlaceholder [
	<pharoJsSkip>
	^PjSortedCollection
]
