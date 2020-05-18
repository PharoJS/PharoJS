"
I manage the message conversions so that for each selector they will be executed in order, with the first successful one adopted. 

See Chain-of-Responsibility pattern.
"
Class {
	#name : #PjMessageConverter,
	#superclass : #Object,
	#instVars : [
		'conversions',
		'astConverter'
	],
	#category : #'PharoJsTranspiler-Kernel'
}

{ #category : #'add/remove' }
PjMessageConverter >> addAllConversions: aCollection [
	aCollection do: [ : aPjOptimization |
		self addConversion: aPjOptimization
	]
]

{ #category : #'add/remove' }
PjMessageConverter >> addConversion: aConversion [
	aConversion isClass
		ifTrue: [ ^ self addConversion: aConversion new ].
	(self conversionsAt: aConversion selector) add: aConversion.
	aConversion messageConverter: self.
]

{ #category : #accessing }
PjMessageConverter >> astConverter [
	^ astConverter
]

{ #category : #accessing }
PjMessageConverter >> astConverter: anObject [
	astConverter := anObject
]

{ #category : #'add/remove' }
PjMessageConverter >> conversionsAt: selector [
	^ conversions
		at: selector
		ifAbsentPut: [ SortedCollection sortBlock: [ :l :r | l order <= r order ] ]
]

{ #category : #converting }
PjMessageConverter >> convert: selector receiver: receiver args: args [
	conversions at: selector ifPresent: [ : collection |
		collection do: [ : conversion |
			(conversion convertReceiver: receiver args: args) ifNotNil: [ : ast | ^ ast ] ]
	].
	^ nil
]

{ #category : #initialization }
PjMessageConverter >> initialize [
	conversions := Dictionary new
]

{ #category : #'add/remove' }
PjMessageConverter >> removeAllConversions: aCollection [
	aCollection do: [ : aConversion |
		self removeConversion: aConversion
	]
]

{ #category : #'add/remove' }
PjMessageConverter >> removeConversion: aConversion [
	aConversion isClass
		ifTrue: [ ^ self removeConversion: aConversion new ].
	(conversions at: aConversion selector
		ifAbsent: [^ self])
			remove: aConversion ifAbsent: []

]
