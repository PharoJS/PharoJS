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
PjES5vsES6BenchmarkChartsApp >> addTo: aCollection dataDictfrom: value stdDeviation: stdDeviation [

	^ aCollection add: {
			  (#y -> value).
			  (#yMin -> (value - stdDeviation)).
			  (#yMax -> (value + stdDeviation)).
			  (#tootipLabel -> (value asString , ' ± ' , stdDeviation asString)) }
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> chartCSV: csvString [

	| csvParseResult canvas chartConfig es5Data es6Data |
	csvParseResult := self parseCsvString: csvString.
	es5Data := OrderedCollection new.
	es6Data := OrderedCollection new.
	csvParseResult data do: [ :row |
		self
			addTo: es5Data
			dataDictfrom: row ES5Median
			stdDeviation: row ES5Deviation.
		self
			addTo: es6Data
			dataDictfrom: row ES6Median
			stdDeviation: row ES6Deviation ].
	chartConfig := {
		               (#type -> 'barWithErrorBars').
		               (#options -> { (#plugins -> {
			                 (#tooltip -> { (#callbacks
			                   ->
			                   { (#label
			                    -> [ :context |
			                    self tooltipLabelForContext: context ]) }) })}).
			                 (#scales -> { (#y -> { (#title -> {
				                    (#display -> true).
				                    (#text -> 'Load Time (ms)') }) }) }) }) .

		               (#data -> {
			                (#labels
			                 -> { 'NodeJS Application'. 'Web Application' }).
			                (#datasets -> {
				                 {
					                 (#label -> 'PharoJS ES5').
					                 (#backgroundColor -> '#ff6699').
					                 (#data -> es5Data) }.
				                 {
					                 (#label -> 'PharoJS ES6').
					                 (#backgroundColor -> '#33ccff').
					                 (#data -> es6Data) } }) }) } asJsObject.
	canvas := self addElement: 'canvas' style: {
			          (#'min-width' -> '400px').
			          (#height -> '400px') }.
	self newChartIn: canvas config: chartConfig
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> initialize [

	super initialize.
	(window fetch: 'data/loadTime.csv')
		then: [ :response |
			response text then: [ :text | self chartCSV: text ] ];
		catch: [ :err | console log: err ]
]

{ #category : #'instance creation' }
PjES5vsES6BenchmarkChartsApp >> newChartIn: containerDom config: chartConfig [

	<javascript: 'return new Chart(containerDom, chartConfig)'>
	
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> parseCsvString: csvString [

	| csvParseResult |
	csvParseResult := window Papa parse: csvString with: {
			                  (#header -> true).
			                  (#dynamicTyping -> true) } asJsObject.
	^ csvParseResult
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> tooltipLabelForContext: aContext [
	^ aContext raw tootipLabel.
]
