"
I am used in tests.

I use all the same mechanisms as PjFileExporter, except I don't output to a file, but rather remember it to be accessed by the contents method.
"
Class {
	#name : #PjTestFileExporter,
	#superclass : #PjFileExporter,
	#instVars : [
		'fileStream'
	],
	#category : #'PharoJsExporter-Kernel'
}

{ #category : #accessors }
PjTestFileExporter >> contents [
	^ self fileStream contents
]

{ #category : #files }
PjTestFileExporter >> fileName [
	^ nil
]

{ #category : #accessors }
PjTestFileExporter >> fileStream [
	^ fileStream ifNil: [ fileStream := WriteStream with: '' ]
]

{ #category : #files }
PjTestFileExporter >> fileStreamClass [
	^ self
]

{ #category : #fileStreamEmulation }
PjTestFileExporter >> newFileNamed: ignored do: aBlockClosure [ 
	^ aBlockClosure value: self fileStream.
]
