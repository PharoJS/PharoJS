"
I am an error from the PharoJS Transpiler that you are doing something wrong:

Possible reasons:
1) you have an open block that you are converting but it has free variables
2) You reference a class that is not in the set of classes that make up your application.
"
Class {
	#name : #PjJavascriptTranspilationError,
	#superclass : #Error,
	#category : #'PharoJsTranspiler-Kernel'
}
