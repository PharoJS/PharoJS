"
I am used in tests.

I use all the same mechanisms as PjFileExporter, except I don't output to a file, but rather remember it to be accessed by the contents method.
"
Class {
	#name : #PjTestFileExporter,
	#superclass : #PjFileExporter,
	#instVars : [
		'writeStream'
	],
	#category : #'PharoJs-Base-Exporter-Kernel'
}

{ #category : #accessing }
PjTestFileExporter >> contents [

	^ self writeStream contents
]

{ #category : #testing }
PjTestFileExporter >> exists [
	^false
]

{ #category : #files }
PjTestFileExporter >> fileName [
	^ nil
]

{ #category : #accessing }
PjTestFileExporter >> fileReferenceFrom: someFileName [

	^ self
]

{ #category : #accessing }
PjTestFileExporter >> writeStream [

	^ writeStream ifNil: [ writeStream := WriteStream with: '' ]
]
