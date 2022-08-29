Class {
	#name : #PjThreeJsGlobals,
	#superclass : #SharedPool,
	#classVars : [
		'BoxGeometry',
		'Mesh',
		'MeshBasicMaterial',
		'PerspectiveCamera',
		'Scene',
		'THREE',
		'TextureLoader',
		'WebGLRenderer'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PharoJs-Examples-ThreeJS'
}

{ #category : #initialization }
PjThreeJsGlobals class >> initialize [

	"self initialize"

	THREE := window THREE.
	WebGLRenderer := THREE WebGLRenderer.
	Scene := THREE Scene.
	BoxGeometry := THREE BoxGeometry.
	MeshBasicMaterial := THREE MeshBasicMaterial.
	Mesh := THREE Mesh.
	PerspectiveCamera := THREE PerspectiveCamera.
	TextureLoader := THREE TextureLoader
]
