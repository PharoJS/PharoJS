"
I provide charts of benchmarks conducted to compare the evolution of the transpiler to generated EcmaScript 6 (ES6) style JS instead of EcmaScript 5 (ES5).
These benchmarks were conducted as part of a paper presented at International Workshop on Smalltalk Technology (IWST) colocated with [ESUG 2023 conference](https://esug.github.io/2023-Conference/conf2023.html) in Lyon, France.

Charts are built using [ChartJS](https://www.chartjs.org) a Simple and flexible JavaScript charting framework.
Just like PharoJS, ChartJS open-source and distributed via GitHub under a MIT License.
"
Class {
	#name : #PjES5vsES6BenchmarkChartsApp,
	#superclass : #PjWebApplication,
	#category : #'PharoJs-Examples-ChartJS'
}

{ #category : #accessing }
PjES5vsES6BenchmarkChartsApp class >> appJsSubFolder [
	<pharoJsSkip>
	^ #js
]

{ #category : #accessing }
PjES5vsES6BenchmarkChartsApp class >> bridgeClientClass [
	<pharoJsSkip>
	^ PjBridgeServedFileBasedBrowserBridgeClient
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> addTo: aCollection dataDictfrom: value stdDeviation: stdDeviation label: dataSetLabel [

	| tootipLabel config |
	tootipLabel := String streamContents: [ :str |
		               str
			               << dataSetLabel;
			               << $:;
			               space;
			               print: value.
			stdDeviation = 0 ifFalse: [
				str
			               << ' ± ';
			               print: stdDeviation] ].
	config := PjJsConfigObject with: [ : cfg | 
cfg
		          y: value;
			          tootipLabel: tootipLabel.
stdDeviation = 0 ifFalse: [cfg			          yMin: value - stdDeviation;
		          yMax: value + stdDeviation]

		].
	aCollection add: config
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> chartCSV: csvString yLabel: yAxisLabel [

	| csvData canvas chartConfig es5Data es6Data es5DataLabel es6DataLabel |
	csvData := self dataFromCSV: csvString.
	es5Data := OrderedCollection new.
	es5DataLabel := 'PharoJS ES5'.
	es6DataLabel := 'PharoJS ES6'.
	es6Data := OrderedCollection new.
	self
		withCsv: csvData
		initEs5: es5Data
		label: es5DataLabel
		es6: es6Data
		label: es6DataLabel.
	chartConfig := self
		               chartConfigYLabel: yAxisLabel
		               es5: es5Data
		               label: es5DataLabel
		               es6: es6Data
		               label: es6DataLabel.
	canvas := self addElement: 'canvas' style: {
			          (#width -> '400px').
			          (#height -> '300px') }.
	self newChartIn: canvas config: chartConfig
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> chartConfigYLabel: yAxisLabel es5: es5Data label: es5DataLabel es6: es6Data label: es6DataLabel [

	^ PjJsConfigObject with: [ :config |
		  config type: #barWithErrorBars.
		  config options with: [ :options |
			  options plugins tooltip callbacks label: [ :context |
				  self tooltipLabelForContext: context ].
			  options scales y title
				  display: true;
				  text: yAxisLabel ].
		  config data with: [ :data |
			  data
				  labels: { 'NodeJS Application'. 'Web Application' };
				  datasets: {
						  (PjJsConfigObject with: [ :dataSet |
								   dataSet
									   label: es5DataLabel;
									   backgroundColor: '#ff6699';
									   data: es5Data ]).
						  (PjJsConfigObject with: [ :dataSet |
							   dataSet
								   label: es6DataLabel;
								   backgroundColor: '#33ccff';
								   data: es6Data ]) } ] ]
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> chartCsvFile: csvFileName label: label [
(window fetch:csvFileName)
		then: [ :response |
			response text then: [ :text |
					self chartCSV: text yLabel: label ] ];
		catch: [ :err | console log: err ]
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> dataFromCSV: csvString [

	| csvParseResult |
	csvParseResult := window Papa parse: csvString with: {
			                  (#header -> true).
			                  (#dynamicTyping -> true) } asJsObject.
	^ csvParseResult data
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> initialize [

	super initialize.
	self
		chartCsvFile: 'data/fileSize.csv' label: 'File Size (KB)';
		chartCsvFile: 'data/exportTime.csv' label: 'Export Time (ms)';
				chartCsvFile: 'data/loadTime.csv' label: 'Load Time (ms)';
		chartCsvFile: 'data/deltaBlue.csv' label: 'Delta Blue Benchmark (ms)';
		chartCsvFile: 'data/richards.csv' label: 'Richards Benchmark (ms)'
]

{ #category : #'instance creation' }
PjES5vsES6BenchmarkChartsApp >> newChartIn: containerDom config: chartConfig [

	^ global Chart new: containerDom with: chartConfig
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> tooltipLabelForContext: aContext [

	^ aContext raw tootipLabel
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> withCsv: csvData initEs5: es5Data label: es5DataLabel es6: es6Data label: es6DataLabel [

	csvData do: [ :row |
		self
			addTo: es5Data
			dataDictfrom: row ES5Median
			stdDeviation: row ES5Deviation
			label: es5DataLabel.
		self
			addTo: es6Data
			dataDictfrom: row ES6Median
			stdDeviation: row ES6Deviation
			label: es6DataLabel ]
]
