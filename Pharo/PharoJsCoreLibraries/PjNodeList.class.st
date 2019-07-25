"
I provide Smalltalk method to the NodeList ""class"" in web browsers. Should not be included in NodeJS code.
"
Class {
	#name : #PjNodeList,
	#superclass : #PjObject,
	#traits : 'PjTArrayLike + PjTExtensionClass',
	#classTraits : 'PjTArrayLike classTrait + PjTExtensionClass classTrait',
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #testing }
PjNodeList class >> includes_jsGenerator [
	<pharoJsSkip>
	^'if (x.', PjTranspiler pharoJsSelectorPrefix, 'isJSPrimitiveType()) {
		if (this.includes(x)) return true;
		for(var i=this.length-1;i>=0;--i) if (x==this[i]) return true;
		return false}		
	for(var i=this.length-1;i>=0;--i) if (x._61_(this[i])) return true;
	return false'
]
