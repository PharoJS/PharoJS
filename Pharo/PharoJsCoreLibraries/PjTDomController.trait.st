"
I provide behavior for a controller for DOM objects.
 I can subscribe to events (e.g. click, change, key stroke) to perform some action when they occur.
The API allows handling both DOM objects direclty or by providing their IDs.

"
Trait {
	#name : #PjTDomController,
	#category : #'PharoJsCoreLibraries-Controllers'
}

{ #category : #creating }
PjTDomController >> addElement: tagString [
	^self addElement: tagString to: self body
]

{ #category : #creating }
PjTDomController >> addElement: tagString style: cssStyleAssociations [
	^self addElement: tagString to: self body style: cssStyleAssociations
]

{ #category : #creating }
PjTDomController >> addElement: tagString to: parentNode [
	| newElement |
	newElement := self createElement: tagString.
	parentNode appendChild: newElement.
	^newElement
]

{ #category : #creating }
PjTDomController >> addElement: tagString to: parentNode style: cssStyleAssociations [
	| newElement |
	newElement := self createElement: tagString style: cssStyleAssociations.
	parentNode appendChild: newElement.
	^ newElement
]

{ #category : #accessing }
PjTDomController >> attribute: attributeName at: elementId [
	^self attribute: attributeName ofElement: (self elementAt: elementId)
]

{ #category : #accessing }
PjTDomController >> attribute: attributeName at: elementId set: attributeValue [
	self attribute: attributeName ofElement: (self elementAt: elementId) set: attributeValue
]

{ #category : #accessing }
PjTDomController >> attribute: attributeName ofElement: domElement [
	^domElement getAttribute: attributeName
]

{ #category : #accessing }
PjTDomController >> attribute: attributeName ofElement: domElement set: attributeValue [
	domElement setAttribute: attributeName to: attributeValue
]

{ #category : #accessing }
PjTDomController >> body [
	^self document body
]

{ #category : #creating }
PjTDomController >> createElement: tagString [ 
	^self document createElement: tagString.

]

{ #category : #creating }
PjTDomController >> createElement: tagString style: cssStyleAssociations [
	| newElement |
	newElement := self document createElement: tagString.
	self setElement: newElement style: cssStyleAssociations.
	^newElement
]

{ #category : #css }
PjTDomController >> cssClassesAddAll: newClasses element: domElement [
	self cssClassesReplaceAll: #() byAll: newClasses element: domElement
]

{ #category : #css }
PjTDomController >> cssClassesElement: domElement [
	^(' ' split: (self cssClassesStringElement: domElement)) 
		"asOrderedCollection reject: [ : each | each isEmpty]"
]

{ #category : #css }
PjTDomController >> cssClassesElement: domElement set: cssClasses [
	| classString |
	classString := ''.
	cssClasses do: [: each |
		classString := classString, ' ', each  ].
	self cssClassesStringElement: domElement set: classString
]

{ #category : #css }
PjTDomController >> cssClassesRemoveAll: oldCssClasses element: domElement [
	self cssClassesReplaceAll: oldCssClasses byAll: #() element: domElement
]

{ #category : #css }
PjTDomController >> cssClassesReplaceAll: oldCssClasses byAll: newClasses element: domElement [
	| cssClasses |
	cssClasses := self cssClassesElement: domElement.
	oldCssClasses do: [: each | cssClasses remove: each ifAbsent: nil].
	cssClasses addAll: newClasses.
	self cssClassesElement: domElement set: cssClasses.
]

{ #category : #css }
PjTDomController >> cssClassesString: elementId [
	^ self cssClassesStringElement: (self elementAt: elementId) 
]

{ #category : #css }
PjTDomController >> cssClassesString: elementId set: attributeValue [
	^ self attribute: #class at: elementId set: attributeValue
]

{ #category : #css }
PjTDomController >> cssClassesStringElement: domElement [
	^ (self attribute: #class ofElement: domElement) ifNil: [ '' ]
]

{ #category : #css }
PjTDomController >> cssClassesStringElement: domElement set: newClassesString [
	self attribute: #class ofElement: domElement set: newClassesString
]

{ #category : #accessing }
PjTDomController >> document [
	self explicitRequirement
]

{ #category : #accessing }
PjTDomController >> elementAt: elementId [
	^self document getElementById: elementId
]

{ #category : #accessing }
PjTDomController >> elementAt: childId in: container [
	"Method querySelector: Returns the first child element that matches a specified 
	CSS selector(s) of an element. To search for an element by Id, we need to use
	a sharp (#) as prefix. A dot (.) should be used for searching by class"
	^container querySelector: '#', childId. 
]

{ #category : #visibility }
PjTDomController >> hide: domElement [
	domElement style display: 'none'
]

{ #category : #visibility }
PjTDomController >> hideElementAt: domElementId in: container [
	self show: false elementAt: domElementId in: container
]

{ #category : #accessing }
PjTDomController >> innerHtmlAt: elementId [
	^(self elementAt: elementId) innerHTML
]

{ #category : #accessing }
PjTDomController >> innerHtmlAt: elementId set: aString [
	(self elementAt: elementId) innerHTML: aString
]

{ #category : #'event init' }
PjTDomController >> onChange: elementId do: aBlock [
	self onChange: elementId in: self body do: aBlock
]

{ #category : #'event init' }
PjTDomController >> onChange: elementId in: container do: aBlock [
	| element |
	element := self elementAt: elementId in: container.
	self onChangeElement: element do: aBlock
]

{ #category : #'event init' }
PjTDomController >> onChangeElement: element do: aBlock [
	element addEventListener: #change block: [ aBlock cull: element value cull: element ]
]

{ #category : #'event init' }
PjTDomController >> onClick: elementId  do: aBlock [
	self onClick: elementId in: self body do: aBlock
]

{ #category : #'event init' }
PjTDomController >> onClick: elementId in: container do: aBlock [
	| element |
	element := self elementAt: elementId in: container.
	self onClickElement: element do: aBlock

]

{ #category : #'event init' }
PjTDomController >> onClickElement: element do: aBlock [
	element addEventListener: #click block: [ aBlock cull: element ].

]

{ #category : #'event init' }
PjTDomController >> onEvent: eventId for: elementId in: container do: aBlock [
	| element |
	element := self elementAt: elementId in: container.
	element addEventListener: eventId block: aBlock
]

{ #category : #'event init' }
PjTDomController >> onKeyUp: elementId do: aBlock [
	self onKeyUp: elementId in: self body do: aBlock
]

{ #category : #'event init' }
PjTDomController >> onKeyUp: elementId in: container do: aBlock [
	| element |
	element := self elementAt: elementId in: container.
	self onKeyUpElement: element do: aBlock
]

{ #category : #'event init' }
PjTDomController >> onKeyUpElement: element do: aBlock [
	element addEventListener: #keyup block: [aBlock cull: element value cull: element ]
]

{ #category : #css }
PjTDomController >> setElement: domElement style: cssStyleAssociations [
	| style |
	style := domElement style.
	cssStyleAssociations asDictionary keysAndValuesDo: [ :key :value | 
		style at: key put: value ]
]

{ #category : #visibility }
PjTDomController >> show: domElement [
	domElement style display: ''
]

{ #category : #visibility }
PjTDomController >> show: aBoolean element: domElement [
	aBoolean ifTrue: [ ^self show: domElement ].
	self hide: domElement
]

{ #category : #visibility }
PjTDomController >> show: aBoolean elementAt: domElementId in: container [
	| element |
	element := self elementAt: domElementId in: container.
	self show: aBoolean element: element
]

{ #category : #visibility }
PjTDomController >> showElementAt: domElementId in: container [
	self show: true elementAt: domElementId in: container
]
