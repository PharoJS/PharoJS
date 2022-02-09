"
I extend STONReader to include Infinity -Infinity and NaN
"
Class {
	#name : #PjSTONReader,
	#superclass : #STONReader,
	#category : #'PharoJs-Base-Bridge-Kernel'
}

{ #category : #'instance creation' }
PjSTONReader class >> from: readStreamOrString [

	^ self new
		  on: readStreamOrString readStream;
		  next
]

{ #category : #private }
PjSTONReader >> isClassStartChar: char [

	^ false
]

{ #category : #'parsing-internal' }
PjSTONReader >> parseConstantDo: block [

	readStream peek = $I ifTrue: [ 
		^ self match: 'Infinity' do: [ block value: Float infinity ] ].
	readStream peek = $- ifTrue: [ 
		^ self
			  match: '-Infinity'
			  do: [ block value: Float infinity negated ] ].
	readStream peek = $N ifTrue: [ 
		^ self match: 'NaN' do: [ block value: Float nan ] ].
	super parseConstantDo: block
]

{ #category : #'parsing-internal' }
PjSTONReader >> parseNumberInteger [

	readStream peek = $I ifTrue: [ 
		self parseConstantDo: [ :val | ^ val ] ].
	^ super parseNumberInteger
]
