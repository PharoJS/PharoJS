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
PjES5vsES6BenchmarkChartsApp >> chartCSV: csvString [

	| canvas data |
	canvas := self addElement: 'canvas'.
	data := window Papa parse: csvString , { 
			                (#header -> true) } asJsObject.
	console log: data
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> initialize [

	| canvas data |
	super initialize.
	canvas := self addElement: 'canvas'.
	data := { 
		        { 
			        (#year -> 2010).
			        (#count -> 10) }.
		        { 
			        (#year -> 2011).
			        (#count -> 20) }.
		        { 
			        (#year -> 2012).
			        (#count -> 15) }.
		        { 
			        (#year -> 2013).
			        (#count -> 25) }.
		        { 
			        (#year -> 2014).
			        (#count -> 22) }.
		        { 
			        (#year -> 2015).
			        (#count -> 30) }.
		        { 
			        (#year -> 2016).
			        (#count -> 28) } } asJsObject.
	self newChartIn: canvas config: { 
			(#type -> 'bar').
			(#data -> { 
				 (#labels -> (data collect: [ :row | row year ])).
				 (#datasets -> { { 
					  (#label -> 'Acquisitions by year').
					  (#data -> (data collect: [ :row | row count ])) } }) }) }
			asJsObject
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> initializeNew [

	super initialize.
	(window fetch: 'data/loadTime.csv')
		then: [ :response | 
			response text then: [ :text | self chartCSV: text ] ];
		catch: [ :err | console log: err ]
]

{ #category : #initialization }
PjES5vsES6BenchmarkChartsApp >> initializeOLD [

	| canvas data |
	super initialize.
	canvas := self addElement: 'canvas'.
	data := { 
		        { 
			        (#year -> 2010).
			        (#count -> 10) }.
		        { 
			        (#year -> 2011).
			        (#count -> 20) }.
		        { 
			        (#year -> 2012).
			        (#count -> 15) }.
		        { 
			        (#year -> 2013).
			        (#count -> 25) }.
		        { 
			        (#year -> 2014).
			        (#count -> 22) }.
		        { 
			        (#year -> 2015).
			        (#count -> 30) }.
		        { 
			        (#year -> 2016).
			        (#count -> 28) } } asJsObject.
	self newChartIn: canvas config: { 
			(#type -> 'bar').
			(#data -> { 
				 (#labels -> (data collect: [ :row | row year ])).
				 (#datasets -> { { 
					  (#label -> 'Acquisitions by year').
					  (#data -> (data collect: [ :row | row count ])) } }) }) }
			asJsObject
]

{ #category : #'instance creation' }
PjES5vsES6BenchmarkChartsApp >> newChartIn: containerDom config: chartConfig [

	<javascript: 'return new Chart(containerDom, chartConfig)'>
	
]
