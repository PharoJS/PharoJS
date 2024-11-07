Class {
	#name : 'PjMethodsAnalysis',
	#superclass : 'Object',
	#instVars : [
		'allPragmaSelectors',
		'allCompiledMethods',
		'thisContextMethods',
		'metricsStream'
	],
	#category : 'PharoJs-Benchmark-Coverage-Analyzer',
	#package : 'PharoJs-Benchmark-Coverage',
	#tag : 'Analyzer'
}

{ #category : 'accessing' }
PjMethodsAnalysis class >> problematicPragmas [

	"Is there a way to at least partially automate extracting this collection?"
	
	^ #(#compilerOptions: #disableReflectivity)
]

{ #category : 'accessing' }
PjMethodsAnalysis >> allMethods [

	^ allCompiledMethods
]

{ #category : 'accessing' }
PjMethodsAnalysis >> allMethods: allMethods [

	allCompiledMethods := allMethods asSortedCollection: [ :a :b |
		                      a selector < b selector ].
	thisContextMethods := allMethods select: [ :each |
		                      each readsThisContext ]
]

{ #category : 'accessing' }
PjMethodsAnalysis >> allPragmaSelectors [

	^ allPragmaSelectors
]

{ #category : 'accessing' }
PjMethodsAnalysis >> allPragmaSelectors: somePragmas [

	allPragmaSelectors := somePragmas asSet asSortedCollection
]

{ #category : 'printing' }
PjMethodsAnalysis >> metricsString [

	^ metricsStream contents
]

{ #category : 'printing' }
PjMethodsAnalysis >> metricsWritingArray [

	| allMethodsCount thisContextMethodsCount |
	allMethodsCount := self allMethods size.
	thisContextMethodsCount := self thisContextMethods size.
	^ {
		  {
			  '------'.
			  Date today.
			  Time now print24 }.
			{ '# Pragmas' }.
		  {
			  '- All Pragmas:'.
			  self allPragmaSelectors size }.
		  { '- Problematic Pragmas: '. 'Count?'. 'Percent?'  }.
		{ '# Methods' }.
		  {
			  '- All Methods:'.
			  allMethodsCount }.
		  {
			  '- Methods reading `thisContext`:'.
			  thisContextMethodsCount.
			  (self percentOf: thisContextMethodsCount by: allMethodsCount) }.
			{ '- Total Methods with a Problematic Pragma:'. 'Count?'. 'Percent?' }.
			{ '- Total Problematic Methods:'. 'Count?'. 'Percent?' } }
]

{ #category : 'printing' }
PjMethodsAnalysis >> percentOf: numerator by: denominator [

	| percent |
	percent := (numerator * 100 / denominator) asFloat.
	^ String streamContents: [ :str |
		  str << $(.
		  percent printOn: str showingDecimalPlaces: 3.
		  str << ' %)' ]
]

{ #category : 'printing' }
PjMethodsAnalysis >> printMetricsOnTranscript [

	self writeMetrics.
	Transcript crShow: self metricsString
]

{ #category : 'accessing' }
PjMethodsAnalysis >> thisContextMethods [

	^ thisContextMethods
]

{ #category : 'printing' }
PjMethodsAnalysis >> writeArray: anArray [

	anArray do: [  :each | 
		metricsStream << each asString
	] separatedBy: [ metricsStream space ]

]

{ #category : 'printing' }
PjMethodsAnalysis >> writeMetrics [

	metricsStream := WriteStream on: String new.
	self metricsWritingArray 
		do: [ :anArray | self writeArray: anArray ]
		separatedBy: [ metricsStream cr ]
]
