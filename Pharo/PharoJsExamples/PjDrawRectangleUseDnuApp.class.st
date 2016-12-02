"
I implement a minimal browser application.

I am a version that needs a working DNU infrastructure.
"
Class {
	#name : #PjDrawRectangleUseDnuApp,
	#superclass : #PjDrawRectangleApp,
	#category : #'PharoJsExamples-DrawRectangle'
}

{ #category : #'initialize - release' }
PjDrawRectangleUseDnuApp >> setupDOM [
	rectangle := document createElement: 'div'.
	rectangle id: 'grn'.
	colour := 'green'.
	rectangle style 
		backgroundColor: colour;
		height: '3cm';
		width: '3cm';
		margin: '-1.5cm';
		position: #absolute;
		left: '100px';
		top: '150px'.
	rectangle innerHTML: 'Clck to change colour'.
	rectangle addEventListener: #click block: [ : ev |
		colour = 'green' ifTrue: [
			colour := 'pink'.
			rectangle style backgroundColor: colour
		] ifFalse: [
			colour = 'pink' ifTrue: [
				colour := 'yellow'.
				rectangle style backgroundColor: colour
			] ifFalse: [
				self flag: 'TODO: firefox requires the listener in removeEventListener'.
				document body removeChild: rectangle.
				self stop
		]]
	].

	document body
		appendChild: rectangle;
		addEventListener: #click block: [ : ev | | x y |
			x := ev pageX.
			y := ev pageY.
			rectangle style
				left: x asString,'px';
				top: y asString,'px'
		]
]

{ #category : #'initialize - release' }
PjDrawRectangleUseDnuApp >> subscribeToDeviceEvents [
	" Bind any events that are required on startup. Common events are:
    	 'load', 'deviceready', 'offline', and 'online'."
	super subscribeToDeviceEvents.
	document addEventListener: 'load' block: [: ev | self onLoad].

]
