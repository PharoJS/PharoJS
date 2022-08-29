"
Simple demo of ThreeJS 3D graphics library.
Shows a cube that can be rotated by pressing keyboard arrow keys.

""Transpile to JS""
PjThreeJsDemo exportApp.

"
Class {
	#name : #PjThreeJsDemo,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'scene',
		'camera',
		'renderer',
		'cube'
	],
	#pools : [
		'PjThreeJsGlobals'
	],
	#category : #'PharoJs-Examples-ThreeJS'
}

{ #category : #description }
PjThreeJsDemo class >> appJsSubFolder [
	<pharoJsSkip>
	^#js
]

{ #category : #initialization }
PjThreeJsDemo >> animate [

	window requestAnimationFrame: [ self animate ].
	renderer render: scene camera: camera
]

{ #category : #initialization }
PjThreeJsDemo >> handleKeydown: keyboardEvent [

	"https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event"

	keyboardEvent key = 'ArrowRight' ifTrue: [ ^ self rotateY: 1 ].
	keyboardEvent key = 'ArrowLeft' ifTrue: [ ^ self rotateY: -1 ].
	keyboardEvent key = 'ArrowUp' ifTrue: [ ^ self rotateX: -1 ].
	keyboardEvent key = 'ArrowDown' ifTrue: [ ^ self rotateX: 1 ]
]

{ #category : #initialization }
PjThreeJsDemo >> initialize [

	| geometry material texture |
	super initialize.
	scene := Scene new.
	camera := PerspectiveCamera
		          new: 75
		          with: window innerWidth / window innerHeight
		          with: 0.1
		          with: 1000.
	renderer := WebGLRenderer new.
	renderer setSize: window innerWidth height: window innerHeight.
	document body appendChild: renderer domElement.
	geometry := BoxGeometry new: 1 with: 1 with: 1.
	texture := TextureLoader new load:
		           'https://pharo.js.org/img/pharoJsBiColorIconWithBorder.jpg'.
	material := MeshBasicMaterial new: { (#map -> texture) } asJsObject.
	cube := Mesh new: geometry with: material.
	scene add: cube.
	camera position z: 5.
	document body
		addEventListener: #keydown
		block: [ :event | self handleKeydown: event ].
	self animate
]

{ #category : #initialization }
PjThreeJsDemo >> rotateX: deltaX [

	| previousRotation newRotation |
	previousRotation := cube rotation x.
	newRotation := previousRotation + (deltaX * 0.1).
	cube rotation x: newRotation
]

{ #category : #initialization }
PjThreeJsDemo >> rotateY: deltaY [

	| previousRotation newRotation |
	previousRotation := cube rotation y.
	newRotation := previousRotation + (deltaY * 0.1).
	cube rotation y: newRotation
]
