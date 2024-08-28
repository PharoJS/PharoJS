Class {
	#name : 'PjCoverageBenchmark',
	#superclass : 'Object',
	#instVars : [
		'errorClasses',
		'successClasses',
		'failures',
		'duration',
		'processedClasses'
	],
	#category : 'PharoJs-Benchmark-Coverage',
	#package : 'PharoJs-Benchmark-Coverage'
}

{ #category : 'benchmarking' }
PjCoverageBenchmark >> benchAllClasses: classesToAnalyse [

	processedClasses := classesToAnalyse.
	Transcript
		cr;
		show: '>>>Transpilation coverage benchmark started'.
			duration := [
	            processedClasses withIndexDo: [ :each :index |
		            self benchClass: each index: index.
		            Processor yield ] ] timeToRun.
	self traceSummary
]

{ #category : 'benchmarking' }
PjCoverageBenchmark >> benchAllImageClasses [

	[self benchAllClasses: SystemNavigation default allClasses] fork
]

{ #category : 'benchmarking' }
PjCoverageBenchmark >> benchClass: aClass index: index [

	| result |
	Transcript
		cr;
		show: index;
		show: ') ';
		show: aClass name;
		show: ' : '.
	result := [ self newTranspiler convertClass: aClass ]
		          on: Error
		          do: [ 
			Transcript show: 'ERROR!!!'.
			^ errorClasses add: aClass ].
	result isSuccess ifTrue: [ 
		Transcript show: 'OK :-)'.
		^ successClasses add: aClass ].
	Transcript show: 'Failed'.
	failures add: result
]

{ #category : 'benchmarking' }
PjCoverageBenchmark >> classDeclarationFailures [

	^failures collect: #isClassDeclarationFailed
]

{ #category : 'accessing' }
PjCoverageBenchmark >> errorClasses [

	^ errorClasses
]

{ #category : 'benchmarking' }
PjCoverageBenchmark >> failedMethodsCount [

	^ self methodTranspileFailures
		  inject: 0
		  into: [ :total :result | total + result failedMethods size ]
]

{ #category : 'initialization' }
PjCoverageBenchmark >> initialize [ 
	super initialize.
	failures := Set new.
	successClasses := Set new.
	errorClasses := Set new.
]

{ #category : 'benchmarking' }
PjCoverageBenchmark >> methodTranspileFailures [

	^failures select: #isMethodTranspilationFailed
]

{ #category : 'benchmarking' }
PjCoverageBenchmark >> newTranspiler [
	^self transpilerClass new
]

{ #category : 'accessing' }
PjCoverageBenchmark >> successClasses [

	^ successClasses
]

{ #category : 'benchmarking' }
PjCoverageBenchmark >> totalMethodsCount [
	^processedClasses inject: 0 into: [ : total : cl | total + cl selectors size ]
]

{ #category : 'benchmarking' }
PjCoverageBenchmark >> traceSummary [

	Transcript
		cr;
		show: '>>>Transpilation coverage benchmark finished';
		cr;
		show: '- Duration: ';
		show: duration humanReadablePrintString;
		cr;
		show: '- Total Processed classes: ';
		show: processedClasses size;
		cr;
		show: '- Passing classes: ';
		show: self successClasses size;
		cr;
		show: '- Class with Declaration Failures: ';
		show: self classDeclarationFailures size;
		cr;
		show: '- Classes with Method Failures: ';
		show: self methodTranspileFailures size;
		cr;
		show: '- Others Errors: ';
		show: self errorClasses size;
		cr;
		show: '- Total Methods: ';
		show: self totalMethodsCount;
		cr;
		show: '- Failed Methods: ';
		show: self failedMethodsCount
]

{ #category : 'benchmarking' }
PjCoverageBenchmark >> transpilerClass [

	^ PjCoverageTranspiler
]
