Class {
	#name : #PjCoverageBenchmark,
	#superclass : #Object,
	#instVars : [
		'errorClasses',
		'successClasses',
		'failures',
		'duration',
		'startTimeStamp'
	],
	#category : #'PharoJs-Benchmark-Coverage'
}

{ #category : #benchmarking }
PjCoverageBenchmark >> benchAllClasses: classes [

	| allClasses |
	startTimeStamp := DateAndTime now.
	allClasses := SystemNavigation default allClasses.
	Transcript
		cr;
		show: '>>>Transpilation coverage benchmark started';
		cr;
		show: 'Time: ';
		show: startTimeStamp asTime print24;
		cr;
		show: 'Date: ';
		show: startTimeStamp asDate;
		cr;
		show: 'Classes Count: ';
		show: classes size.
	duration := [ classes withIndexDo: [ :each :index | self benchClass: each index: index] ]
		            timeToRun.
	Transcript
		cr;
		show: '>>>Transpilation coverage benchmark finished after ';
		show: duration humanReadablePrintString
]

{ #category : #benchmarking }
PjCoverageBenchmark >> benchAllImageClasses [
self benchAllClasses: SystemNavigation default allClasses
]

{ #category : #benchmarking }
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

{ #category : #benchmarking }
PjCoverageBenchmark >> convertToJs: aClass [

	| result |
	result := [self newTranspiler convertClass: aClass] on: Error do: [^errorClasses add: aClass].
	result isSuccess ifTrue: [ ^successClasses add: aClass ].
	failures add: result
]

{ #category : #accessing }
PjCoverageBenchmark >> errorClasses [

	^ errorClasses
]

{ #category : #accessing }
PjCoverageBenchmark >> failures [

	^ failures
]

{ #category : #initialization }
PjCoverageBenchmark >> initialize [ 
	super initialize.
	failures := Set new.
	successClasses := Set new.
	errorClasses := Set new.
]

{ #category : #benchmarking }
PjCoverageBenchmark >> newTranspiler [
	^self transpilerClass new
]

{ #category : #accessing }
PjCoverageBenchmark >> successClasses [

	^ successClasses
]

{ #category : #benchmarking }
PjCoverageBenchmark >> transpilerClass [

	^ PjCoverageTranspiler
]
