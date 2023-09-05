"
I provide charts of benchmarks conducted to compare the evolution of the transpiler to generated EcmaScript 6 (ES6) style JS instead of EcmaScript 5 (ES5).
These benchmarks were conducted as part of a paper presented at International Workshop on Smalltalk Technology (IWST) colocated with [ESUG 2023 conference](https://esug.github.io/2023-Conference/conf2023.html) in Lyon, France.

Charts are built using [ChartJS](https://www.chartjs.org) a Simple and flexible JavaScript charting framework.
Just like PharoJS, ChartJS open-source and distributed via GitHub under a MIT License.
"
Class {
	#name : #PjES5vsES6BenchmarkChartsApp,
	#superclass : #PjWebApplication,
	#instVars : [
		'chartsContainer'
	],
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

{ #category : #'chart creation' }
PjES5vsES6BenchmarkChartsApp >> chartCSVOLD: csvString yLabel: yAxisLabel title: titleString unit: unitString [

	| csvData chartConfig es5Data es6Data es5DataLabel es6DataLabel p10Data p10DataLabel canvas |
	csvData := self dataFromCSV: csvString.
	es5Data := OrderedCollection new.
	es6Data := OrderedCollection new.
	p10Data := OrderedCollection new.
	es5DataLabel := 'PharoJS ES5'.
	es6DataLabel := 'PharoJS ES6'.
	p10DataLabel := 'Pharo 10'.
	self
		withCsv: csvData
		initEs5: es5Data
		label: es5DataLabel
		es6: es6Data
		label: es6DataLabel
		unit: unitString
		pharo10: p10Data
		label: p10DataLabel.
	chartConfig := self
		               chartConfigYLabel: yAxisLabel
		               es5: es5Data
		               label: es5DataLabel
		               es6: es6Data
		               label: es6DataLabel
		               pharo10: p10Data
		               label: p10DataLabel.
	canvas := self newCanvasWithTitle: titleString.
	self newChartIn: canvas config: chartConfig
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> chartCSVString: csvString yLabel: yAxisLabel title: titleString unit: unitString [

	| csvData chartFactoryClass |
	csvData := self dataFromCSV: csvString.
	chartFactoryClass := self chartFactoryClassForCsvData: csvData.
	^chartFactoryClass
		chartData: csvData
		yLabel: yAxisLabel
		title: titleString
		unit: unitString
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> chartCsvFile: csvFileName label: label title: titleString unit: unitString [

	(window fetch: csvFileName)
		then: [ :response |
			response text then: [ :text |
					self chartCSVString: text yLabel: label title: titleString unit: unitString ] ];
		catch: [ :err | console log: err ]
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> chartFactoryClassForCsvData: csvData [
csvData last app = 'Pharo10' ifTrue: [^PjES5vsES6vsPharo10ChartJsFactory ]
. ^PjES5vsES6ChartJsFactory 
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
	chartsContainer := self elementAt: #chartsContainer.
	self
		chartCsvFile: 'data/exportTime.csv'
		label: 'Export Time (ms)'
		title: 'JS Export Time'
		unit: 'ms';
		chartCsvFile: 'data/loadTime.csv'
		label: 'Load Time (ms)'
		title: 'JS Load Time'
		unit: 'ms';
		chartCsvFile: 'data/deltaBlue.csv'
		label: 'Delta Blue Benchmark (ms)'
		title: 'Delta Blue Benchmark'
		unit: 'ms';
		chartCsvFile: 'data/richards.csv'
		label: 'Richards Benchmark (ms)'
		title: 'Richards Benchmark'
		unit: 'ms';
		chartCsvFile: 'data/fileSize.csv'
		label: 'File Size (KB)'
		title: 'JS File Size'
		unit: 'KB'
]

{ #category : #'chart creation' }
PjES5vsES6BenchmarkChartsApp >> withCsv: csvData initEs5: es5Data label: es5DataLabel es6: es6Data label: es6DataLabel unit: unitString pharo10: p10Data label: p10DataLabel [

	| es5 es6 es5Label es6Label |
	csvData do: [ :row |
		row app == 'Pharo10'
			ifTrue: [
				es5 := p10Data.
				es6 := p10Data.
				es5Label := p10DataLabel.
				es6Label := p10DataLabel ]
			ifFalse: [
				es5 := es5Data.
				es6 := es6Data.
				es5Label := es5DataLabel.
				es6Label := es6DataLabel ]. self
			addTo: es5
			dataDictfrom: row ES5Median
			stdDeviation: row ES5Deviation
			label: es5Label
			unit: unitString.
		self
			addTo: es6
			dataDictfrom: row ES6Median
			stdDeviation: row ES6Deviation
			label: es6Label
			unit: unitString ]
]
