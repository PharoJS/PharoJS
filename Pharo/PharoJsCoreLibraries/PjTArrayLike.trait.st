"
I provide behavior shared between JS classes that should have array-like behavior but that does not fit Array. 

Examples are: HTMLCollection and NodeList. From the JS point of view, they are not constructors, so we can't instantiate them for creating subcollections (as with e.g. allButFirst). So, we redefine method species to answer Array.
"
Trait {
	#name : #PjTArrayLike,
	#traits : 'PjTArray',
	#classTraits : 'PjTArray classTrait',
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #testing }
PjTArrayLike classSide >> includes_jsGenerator [
	<pharoJsSkip>
	^'if (x.', PjTranspiler pharoJsSelectorPrefix, 'isJSPrimitiveType()) {
		if (this.includes(x)) return true;
		for(var i=this.length-1;i>=0;--i) if (x==this[i]) return true;
		return false}		
	for(var i=this.length-1;i>=0;--i) if (x._61_(this[i])) return true;
	return false'
]

{ #category : #accessing }
PjTArrayLike >> indexOf: x [
	<javascript: 'for(var i = 0; i < this.length; i++){
		if(x == this[i]){return i + 1}
	}
	return 0;
	'>
]

{ #category : #accessing }
PjTArrayLike >> species [
	^Array
]
