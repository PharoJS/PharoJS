Class {
	#name : #PjExportBenchmarks,
	#superclass : #Object,
	#category : #'PharoJs-Benchmarking-Application'
}

{ #category : #benchmarking }
PjExportBenchmarks class >> benchAllExport [

	<script>
	self benchExportingNodeTimingApplication.
	self benchExportingBrowserTimingApplication 
]

{ #category : #benchmarking }
PjExportBenchmarks class >> benchExporting: appClass [

	self benchExporting: appClass runsCount: self runsCount
]

{ #category : #benchmarking }
PjExportBenchmarks class >> benchExporting: appClass runsCount: runs [

	self new benchExporting: appClass runsCount: runs
]

{ #category : #benchmarking }
PjExportBenchmarks class >> benchExportingBrowserTimingApplication [
	<script>
	self benchExporting: PjBrowserTimingApplication 
]

{ #category : #benchmarking }
PjExportBenchmarks class >> benchExportingNodeTimingApplication [
	<script>
	self benchExporting: PjNodeTimingApplication 
]

{ #category : #benchmarking }
PjExportBenchmarks class >> runExporting: appClass [

	self new runExporting: appClass
]

{ #category : #benchmarking }
PjExportBenchmarks class >> runsCount [

	^ 100
]

{ #category : #benchmarking }
PjExportBenchmarks >> benchExporting: appClass runsCount: runs [

	Transcript
		cr;
		cr;
		show: '--- ';
		show: appClass;
		show: ' export bench at: ';
		show: Time now print24;
		show: ' - runs: ';
		show: runs;
		show: '------------'.
	runs timesRepeat: [ self runExporting: appClass ]
]

{ #category : #benchmarking }
PjExportBenchmarks >> export: appClass [

	| exporter |
	exporter := PjExporter newWithAppClass: appClass.
	^exporter javascriptCode
]

{ #category : #benchmarking }
PjExportBenchmarks >> runExporting: appClass [

	Smalltalk garbageCollect.
	Transcript
		  cr;
		  show: [ self export: appClass ]
		                         timeToRunWithoutGC.
]
