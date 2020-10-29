"
Displays statistics of classes converted from Pharo to JS on the Transcript.

Examples

Transcript clear.
PjStatistics statsForApp: PjCounterBrowserApp .

PjStatistics statsForAll: { PjHelloWorldApp. PjMinimalBrowserApplication}
"
Class {
	#name : #PjStatistics,
	#superclass : #Object,
	#category : #PharoJsStatistics
}

{ #category : #statistics }
PjStatistics class >> statsForAll: appClasses [
	appClasses do: [ : cl | self statsForApp: cl ]
]

{ #category : #statistics }
PjStatistics class >> statsForApp: appClass [
	| exporter actuallyExportedClasses methodsCount jsCode |
	exporter := appClass exporterClass newWithAppClass: appClass.
	jsCode := String streamContents: [ :stream | exporter writeJsCodeOn: stream ].
	actuallyExportedClasses := exporter bootstrapClasses asSet
		, exporter nonBootstrapClasses asSet collect: #classToUseForJsConversion.
	methodsCount := actuallyExportedClasses
		inject: 0
		into: [ :count :cl | count + cl selectors size ].
	Transcript 
		cr;
		show: '----------------';
		cr;
		show: appClass name;
		show: ' - ';
		show: Date today;
		show: ' - ';
		show: Time now print24;
		cr;
		cr;
		show: 'Classes: ';
		show: actuallyExportedClasses size;
		cr;
		show: 'Methods: ';
		show: methodsCount;
		cr;
		show: 'Exported JS: ';
		show: jsCode size humanReadableSIByteSize;
		cr;
		show: '----------------'
]
