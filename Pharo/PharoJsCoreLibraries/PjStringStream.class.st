"
I am a simplistic implementation of a String ReadWriteStream
"
Class {
	#name : #PjStringStream,
	#superclass : #PjReadWriteStream,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'instance creation' }
PjStringStream class >> on: aCollection [
	^ self new on: aCollection
]

{ #category : #'initialize-release' }
PjStringStream >> emptyCollection [
	^ ''
]

{ #category : #accessing }
PjStringStream >> join [
	^ '' join: array
]

{ #category : #accessing }
PjStringStream >> nextPut: aCharacter [
	array addLast: aCharacter asString.
	^ aCharacter
]

{ #category : #accessing }
PjStringStream >> nextPutAll: aString [
	array addLast: aString.
	^ aString
]
