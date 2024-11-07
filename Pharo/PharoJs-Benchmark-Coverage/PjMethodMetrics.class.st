Class {
	#name : 'PjMethodMetrics',
	#superclass : 'Object',
	#instVars : [
		'stream',
		'allPragmaSelectors'
	],
	#category : 'PharoJs-Benchmark-Coverage',
	#package : 'PharoJs-Benchmark-Coverage'
}

{ #category : 'accessing' }
PjMethodMetrics class >> problematicPragmas [

	"Is there a way to at least partially automate extracting this collection?"
	
	^ #(#compilerOptions: #disableReflectivity)
]

{ #category : 'accessing' }
PjMethodMetrics >> allPragmaSelectors [

	^ allPragmaSelectors
]

{ #category : 'accessing' }
PjMethodMetrics >> allPragmaSelectors: somePragmas [

	allPragmaSelectors := somePragmas asSet asSortedCollection
]

{ #category : 'converting' }
PjMethodMetrics >> asString [
	^stream contents
]

{ #category : 'printing' }
PjMethodMetrics >> printOnTranscript [

	self write.
	Transcript crShow: self asString
]

{ #category : 'printing' }
PjMethodMetrics >> write [

	stream := WriteStream on: String new.
	self writeLabel: '# of Pragma Selectors: ' value: self allPragmaSelectors size
]

{ #category : 'printing' }
PjMethodMetrics >> writeLabel: labelString value: aNumber [ 
	stream 
		<< labelString ;
		print: aNumber
		
		
]
