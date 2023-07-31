"
I am a minimal implementation of Rectangle, just so Point can create me.
"
Class {
	#name : #PjRectangle,
	#superclass : #PjObject,
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'pharojs support' }
PjRectangle class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ {
		  (Rectangle
		   ->
			   #( containsPoint: #setPoint:point: #center #bottomRight
			      #topRight #bottomLeft #topLeft )).
		  (Rectangle class -> #( #origin:corner: )) }
]
