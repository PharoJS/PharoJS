Class {
	#name : #PjES5vsES6vsPharo10ChartJsFactory,
	#superclass : #PjES5vsES6ChartJsFactory,
	#instVars : [
		'p10Data'
	],
	#category : #'PharoJs-Examples-ChartJS'
}

{ #category : #'chart creation' }
PjES5vsES6vsPharo10ChartJsFactory >> configDataSets [

	^super configDataSets copyWith: (config datasets copyWith: PjConfig << [ :dataSet |
			 dataSet
				 label: self p10DataLabel;
				 backgroundColor: 'gray';
				 data: p10Data ]).
]

{ #category : #'chart creation' }
PjES5vsES6vsPharo10ChartJsFactory >> initDataFromRow: row unit: unitString [

	row app == 'Pharo10' ifFalse: [
		^ super initDataFromRow: row unit: unitString ].
	self
		initDataFromRow: row
		unit: unitString
		es5: p10Data
		es5Label: self p10DataLabel
		es6: p10Data
		es6Label: self p10DataLabel
]

{ #category : #initialization }
PjES5vsES6vsPharo10ChartJsFactory >> initialize [ 
	super initialize .
p10Data := OrderedCollection new.
]

{ #category : #accessing }
PjES5vsES6vsPharo10ChartJsFactory >> p10DataLabel [ ^'Pharo 10'.
	
]
