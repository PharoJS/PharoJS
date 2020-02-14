"
I am a minimal implementation of Rectangle, just so Point can create me.
"
Class {
	#name : #PjRectangle,
	#superclass : #PjObject,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharojs support' }
PjRectangle class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ {(Rectangle  
				->
					#(containsPoint: setPoint:point:)).
		(Rectangle class 
				->
					#(origin:corner:)).
							}
]
