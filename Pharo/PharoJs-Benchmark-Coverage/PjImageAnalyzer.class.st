Class {
	#name : 'PjImageAnalyzer',
	#superclass : 'Object',
	#category : 'PharoJs-Benchmark-Coverage-Analyzer',
	#package : 'PharoJs-Benchmark-Coverage',
	#tag : 'Analyzer'
}

{ #category : 'utility' }
PjImageAnalyzer class >> inspectAnalysis [

	<example>
	self newAnalysis inspect
]

{ #category : 'utility' }
PjImageAnalyzer class >> newAnalysis [

	^self new newAnalysis
]

{ #category : 'utility' }
PjImageAnalyzer class >> printMetricsOnTranscript [

	<example>
	self newAnalysis printMetricsOnTranscript
]

{ #category : 'anlyzing' }
PjImageAnalyzer >> findAllMethods [

	^ SystemNavigation default allMethods
]

{ #category : 'anlyzing' }
PjImageAnalyzer >> findAllPragmaSelectors [

	^ Pragma all asSet collect: #selector
]

{ #category : 'building' }
PjImageAnalyzer >> newAnalysis [

	^PjMethodsAnalysis new
		allPragmaSelectors: self findAllPragmaSelectors;
		allMethods: self findAllMethods;
		yourself
]
