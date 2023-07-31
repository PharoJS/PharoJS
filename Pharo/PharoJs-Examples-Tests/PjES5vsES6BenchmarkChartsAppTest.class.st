Class {
	#name : #PjES5vsES6BenchmarkChartsAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PharoJs-Examples-Tests-ChartJS'
}

{ #category : #'suite parameters' }
PjES5vsES6BenchmarkChartsAppTest class >> appClass [

	^ PjES5vsES6BenchmarkChartsApp 
]

{ #category : #tests }
PjES5vsES6BenchmarkChartsAppTest >> testAllCanvasBuilt [

	| allCanvas emptyCanvas emptyCanvasUrl aCanvas |
	self
		waitUntil: [
			allCanvas := document querySelectorAll: 'canvas'.
			allCanvas size = 5 ].
	emptyCanvas := document createElement: 'canvas'.
	emptyCanvas width: allCanvas first width.
	emptyCanvas height: allCanvas first height.
	emptyCanvasUrl = emptyCanvas toDataURL.
	1 to: 5 do: [ :index |
		aCanvas := allCanvas at: index.
		self deny: aCanvas toDataURL = emptyCanvasUrl ]
]
