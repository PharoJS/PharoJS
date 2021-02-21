"
Example of app using data visualisation library D3JS https://d3js.org/
Displays a graph with clickable and draggable nodes
"
Class {
	#name : #PjDisjointForceDirectedGraphExample,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'simulation',
		'svg',
		'svgLinks',
		'svgNodes',
		'dataLinks',
		'dataNodes'
	],
	#pools : [
		'PjD3JsGlobals'
	],
	#category : #'PharoJsExamples-D3JS'
}

{ #category : #initialization }
PjDisjointForceDirectedGraphExample >> addMouseActions [
	svgNodes on: 'click' do: [ : event | self onClick: event].
	svgNodes call: self onDrag.
]

{ #category : #initialization }
PjDisjointForceDirectedGraphExample >> createSimulationWith: data [
	| forceId distance strength |
	dataNodes := data result nodes.
	dataLinks := data result links.
	simulation := d3 forceSimulation: dataNodes.
	forceId := (d3 forceLink: dataLinks) id: [: d | d id].
	distance := forceId distance: [ : d  | 1.0 / d score].
	strength := distance strength: [ : d | d score ].
	simulation force: 'link' with: strength.
 	simulation force: 'charge' with: d3 forceManyBody.
   simulation force: 'center' with: d3 forceCenter.	
]

{ #category : #initialization }
PjDisjointForceDirectedGraphExample >> createSvg [
	| obj |
	svg := d3 create: 'svg'.
	svg attr: 'preserveAspectRatio' with: 'xMidYMid meet'.
   obj := (svg append: 'g').
	obj := obj attr: 'stroke' with: '#999'.
	obj := obj attr: 'stroke-opacity' with: 0.8.
	obj := obj selectAll: 'line'.
	obj := obj data: dataLinks.
	obj := obj join: 'line'.
	svgLinks := obj attr: 'stroke-width' with: [ : d | d score * 7.0 ].
	obj :=  svg append: 'g'.
	obj := obj attr: 'stroke' with: '#fff'.
	obj := obj attr: 'stroke-opacity' with: 0.5.
	obj := obj selectAll: 'circle'.
	obj := obj data: dataNodes.
	obj := obj join: 'circle'.
	obj := obj attr: 'r' with: 5.
	svgNodes := obj attr: 'fill' with: [self randomColor].

]

{ #category : #initialization }
PjDisjointForceDirectedGraphExample >> d3 [
	^d3
]

{ #category : #initialization }
PjDisjointForceDirectedGraphExample >> initialize [
	super initialize.
	(d3 json: 'graph.json')
		then: [ :data | 
			| node |
			self createSimulationWith: data.
			self createSvg.
			self addMouseActions.
			node := svg node.
			document body append: node.
			simulation
				on: #tick
				do: [ self updateDisplay ] ]
]

{ #category : #accessing }
PjDisjointForceDirectedGraphExample >> maxOf: aCollection [
	<javascript: 'return Math.max(...aCollection)'>
]

{ #category : #accessing }
PjDisjointForceDirectedGraphExample >> minOf: aCollection [
	<javascript: 'return Math.min(...aCollection)'>
]

{ #category : #initialization }
PjDisjointForceDirectedGraphExample >> onClick: event [
	| clickedNode index |
	clickedNode := event target.
	index := clickedNode parentNode children indexOf: clickedNode. 
	window alert: (dataNodes at: index) title.
]

{ #category : #initialization }
PjDisjointForceDirectedGraphExample >> onDrag [
	| dragStarted dragged dragEnded obj |
	dragStarted := [: event |
		event active ifFalse: [ (simulation alphaTarget: 0.3) restart ].
		event subject at: #fx put: event  subject x.
		event subject at: #fy put: event  subject y.
   ].
  	dragged := [: event| 
		event subject at: #fx put: event x.
		event subject at: #fy put: event y.
 	].              
   dragEnded := [: event| 
		event active ifFalse: [simulation alphaTarget: 0].
		event subject fx: nil.
		event subject fy: nil.
	].
	obj := d3 drag.
	obj := obj on: 'start' with: dragStarted.
	obj := obj on: 'drag' with: dragged.
	^obj on: 'end' with: dragEnded
]

{ #category : #initialization }
PjDisjointForceDirectedGraphExample >> randomColor [
	| colors randomIndex |
	colors := #(pink red blue green yellow orange purple).
	randomIndex := self randomIndexOf: colors.
	^colors at: randomIndex
]

{ #category : #initialization }
PjDisjointForceDirectedGraphExample >> randomIndexOf: aCollection [
	<javascript: 'let min = 1;
  let max = aCollection.length;
  return Math.floor(Math.random() * (max - min) + min);'>
]

{ #category : #initialization }
PjDisjointForceDirectedGraphExample >> updateDisplay [
	| nodes_x nodes_y min_x min_y w h |
	svgLinks
		attr: 'x1' with: [: d | d source x];
		attr: 'y1' with: [: d | d source y];
		attr: 'x2' with: [: d | d target x];
		attr: 'y2' with: [: d | d target y].

	svgNodes
		attr: 'cx' with: [: d | d x];
		attr: 'cy' with: [: d | d y].
 	nodes_x := dataNodes map: [: d | d x].
 	nodes_y := dataNodes map: [: d | d y].
	min_x := (self minOf: nodes_x) - 10.
	min_y := (self minOf: nodes_y) - 10.
	w := (self maxOf: nodes_x)  - min_x + 10.
	h := (self maxOf: nodes_y)  - min_y + 10.
   svg attr: 'viewBox' bounds: {min_x. min_y. w. h}.

]
