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

{ #category : #accessing }
PjStringStream >> << aCharacterOrString [

	array addLast: aCharacterOrString asString
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
