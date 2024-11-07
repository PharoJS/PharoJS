Class {
	#name : 'PjMethodMetricsFactory',
	#superclass : 'Object',
	#category : 'PharoJs-Benchmark-Coverage',
	#package : 'PharoJs-Benchmark-Coverage'
}

{ #category : 'utility' }
PjMethodMetricsFactory class >> inspectMetrics [

	<example>
	self new newMetrics inspect
]

{ #category : 'utility' }
PjMethodMetricsFactory class >> printMetrics [

	<example>
	self new printNewMetrics
]

{ #category : 'anlyzing' }
PjMethodMetricsFactory >> findAllPragmaSelectors [

	^ Pragma all asSet collect: #selector
]

{ #category : 'building' }
PjMethodMetricsFactory >> newMetrics [

	| newMetrics |
	newMetrics := PjMethodMetrics new.
	newMetrics allPragmaSelectors: self findAllPragmaSelectors.
	^newMetrics 
]

{ #category : 'building' }
PjMethodMetricsFactory >> printNewMetrics [

	self newMetrics printOnTranscript 
]
