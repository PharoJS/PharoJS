"
I implement a minimal browser application.

I am a version that doesn't need a DNU infrastructure.
"
Class {
	#name : #PjDrawRectangleNoDnuApp,
	#superclass : #PjDrawRectangleApp,
	#category : #'PharoJsExamples-DrawRectangle'
}

{ #category : #'initialize - release' }
PjDrawRectangleNoDnuApp >> setupDOM [
	rectangle := document js_createElement: 'div'.
	rectangle js_at:#id put: 'grn'.
	colour := 'green'.
	(rectangle js_at:#style)
		js_at:#backgroundColor put: colour;
		js_at:#height put: 3cm;
		js_at:#width put: 3cm;
		js_at:#margin put: -1.5cm;
		js_at:#position put: #absolute;
		js_at:#left put: 100px;
		js_at:#top put: 150px.
	rectangle js_at:#innerHTML put: 'Clck to ','' capitalized,'change' capitalized,' colour'.
	rectangle js_addEventListener: #click block: [ : ev |
		colour = 'green' ifTrue: [
			colour := 'pink'.
			(rectangle js_at:#style) js_at:#backgroundColor put: colour
		] ifFalse: [
			colour = 'pink' ifTrue: [
				colour := 'yellow'.
			(rectangle js_at:#style) js_at:#backgroundColor put: colour
			] ifFalse: [
"				self flag: 'TODO: firefox requires the listener in removeEventListener'.
"				(document js_at:#body) js_removeChild: rectangle.
				self stop
		]]
	].

	(document js_at:#body)
		js_appendChild: rectangle;
		js_addEventListener: #click block: [ : ev | | x y |
			x := ev js_at:#pageX.
			y := ev js_at:#pageY.
			(rectangle js_at:#style)
				js_at:#left put: x px;
				js_at:#top put: y px
		]
]

{ #category : #'initialize - release' }
PjDrawRectangleNoDnuApp >> subscribeToDeviceEvents [
	" Bind any events that are required on startup. Common events are:
    	 'load', 'deviceready', 'offline', and 'online'."
	super subscribeToDeviceEvents.
	document js_addEventListener: 'load' block: [: ev | self onLoad].
]
