"
I am a simplistic implementation of an Array ReadWriteStream
"
Class {
	#name : #PjArrayStream,
	#superclass : #PjReadWriteStream,
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'instance creation' }
PjArrayStream class >> on: aCollection [
	^ self new on: aCollection
]

{ #category : #'initialize-release' }
PjArrayStream >> emptyCollection [
	^ #()
]

{ #category : #accessing }
PjArrayStream >> join [
	| temp |
	temp := OrderedCollection new.
	array do: [: each |
		each do: [: element |
			temp addLast: element
		]
	].
	^ temp
]

{ #category : #accessing }
PjArrayStream >> nextPut: aValue [
	array addLast: {aValue}.
	^ aValue
]
