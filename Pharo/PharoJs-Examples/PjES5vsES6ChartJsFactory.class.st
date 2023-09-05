Class {
	#name : #PjES5vsES6ChartJsFactory,
	#superclass : #PjDomController,
	#instVars : [
		'chartsContainer',
		'config',
		'es5Data',
		'es6Data'
	],
	#category : #'PharoJs-Examples-ChartJS'
}

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory class >> chartData: csvData yLabel: yAxisLabel title: titleString unit: unitString [

	^ self new
		  chartData: csvData
		  yLabel: yAxisLabel
		  title: titleString
		  unit: unitString
]

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory >> addTo: aCollection dataDictfrom: value stdDeviation: stdDeviation label: dataSetLabel unit: unitString [

	| tootipLabel  |
	tootipLabel := String streamContents: [ :str |
		               str
			               << dataSetLabel;
			               << $:;
			               space;
			               print: value;
			               << unitString.
		               stdDeviation = 0 ifFalse: [
			               str
				               << ' ± ';
				               print: stdDeviation ] ].
	config := PjConfig << [ :cfg |
	          cfg
		          y: value;
		          tootipLabel: tootipLabel.
	          stdDeviation = 0 ifFalse: [
		          cfg
			          yMin: value - stdDeviation;
			          yMax: value + stdDeviation ] ].
	aCollection add: config
]

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory >> chartData: csvData yLabel: yAxisLabel title: titleString unit: unitString [

	self initDataFrom: csvData unit: unitString.
	self initConfigWithYLabel: yAxisLabel.
	^ self newChartWithTitle: titleString
]

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory >> configDataSets [
	^{
				(PjConfig << [ :dataSet |
					 dataSet
						 label: self es5DataLabel;
						 backgroundColor: '#ff6699';
						 data: es5Data ]).
				(PjConfig << [ :dataSet |
				 dataSet
					 label: self es6DataLabel;
					 backgroundColor: '#33ccff';
					 data: es6Data ]) }
]

{ #category : #accessing }
PjES5vsES6ChartJsFactory >> es5DataLabel [

	^ 'PharoJS ES5'
]

{ #category : #accessing }
PjES5vsES6ChartJsFactory >> es6DataLabel [

	^ 'PharoJS ES6'
]

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory >> initConfigWithYLabel: yAxisLabel [

	config type: #barWithErrorBars.
	config options << [ :options |
	options
		errorBarWhiskerLineWidth: 2;
		errorBarLineWidth: 2.
	options plugins tooltip callbacks label: self tooltipLabelFunction.
	options scales y title
		display: true;
		text: yAxisLabel ].
	config data << [ :data |
	data
		labels: { 'NodeJS Application'. 'Web Application' };
		datasets: self configDataSets ]
]

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory >> initDataFrom: csvData unit: unitString [

	csvData do: [ :row | self initDataFromRow: row unit: unitString ]
]

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory >> initDataFromRow: row unit: unitString [

	self initDataFromRow: row unit: unitString es5: es5Data es5Label: self es5DataLabel es6: es6Data es6Label: self es6DataLabel

]

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory >> initDataFromRow: row unit: unitString es5: es5 es5Label: es5Label es6: es6 es6Label: es6Label [

		self
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
			unit: unitString
]

{ #category : #initialization }
PjES5vsES6ChartJsFactory >> initialize [

	super initialize.
	chartsContainer := self elementAt: #chartsContainer.
	config := PjConfig new.	es5Data := OrderedCollection new.
	es6Data := OrderedCollection new
]

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory >> newCanvasWithTitle: titleString [

	| card body title |
	card := self addElement: 'div' to: chartsContainer.
	card className: 'card mt-5'.
	body := self addElement: 'div' to: card.
	body className: 'card-body'.
	title := self addElement: 'h3' to: body.
	title className: 'card-title'.
	title textContent: titleString.
	^ self addElement: 'canvas' to: body style: {
			  (#width -> '350px').
			  (#height -> '300px') }
]

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory >> newChartWithTitle: titleString [

	| canvas |
	canvas := self newCanvasWithTitle: titleString.
	^ global Chart new: canvas with: config becomeJsObject
]

{ #category : #'chart creation' }
PjES5vsES6ChartJsFactory >> tooltipLabelFunction [

	^ [ :context | context raw tootipLabel ]
]
