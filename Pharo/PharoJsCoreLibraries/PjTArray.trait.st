"
I implement operations for array-like things in Javascript
"
Trait {
	#name : #PjTArray,
	#traits : 'PjTCollection',
	#classTraits : 'PjTCollection classTrait',
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'pharoJs support' }
PjTArray classSide >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ self jsTranspilationImportMethodsArray
]

{ #category : #'pharoJs support' }
PjTArray classSide >> jsTranspilationImportMethodsArray [
	<pharoJsSkip>
	^ self jsTranspilationImportMethodsCollection,
	{
		Array -> #( isArray ).
		ByteArray -> #( asString).
		OrderedCollection -> #( join: addAllLast:).
		SequenceableCollection -> #(
			doWithIndex: withIndexDo: 
			allButFirst allButFirst: allButLast allButLast:
			copyFrom:to: copyReplaceFrom:to:with: copyWith: copyWithFirst: copyWithoutIndex: from:to:put: grownBy: replaceFrom:to:with: reverseDo: appendTo:
		).
	} 
]

{ #category : #copying }
PjTArray >> , other [
	^ self class new addAll: self; addAll: other; yourself
]

{ #category : #enumerating }
PjTArray >> = anArray [
	<javascript: 'if(this.length!=anArray.length)return false;for(var i=0,max=this.length;i<max;++i)if(this[i]!=anArray[i])return false;return true'>
]

{ #category : #accessing }
PjTArray >> at: i [
	<javascript: 'return this[i-1]'>
]

{ #category : #accessing }
PjTArray >> at: index ifAbsent: aBlock [
	(index > 0 and: [index > self size]) ifTrue: [ ^aBlock value ].
	^self at: index
]

{ #category : #enumerating }
PjTArray >> collect: aBlock [
	<javascript: 'var result=[];for(var i=0,max=this.length;i<max;++i)result.push(typeof aBlock=="string"?this[i]._perform_(aBlock):aBlock(this[i]));return result'>
]

{ #category : #enumerating }
PjTArray >> do: aBlock [
	<javascript: 'for(var i=0,max=this.length;i<max;++i)aBlock(this[i]);return this'>
]

{ #category : #enumerating }
PjTArray >> do: elementBlock separatedBy: separatorBlock [
	<javascript: 'for(var i=0,max=this.length;i<max;++i){if(i)separatorBlock();elementBlock(this[i])};return this'>
]

{ #category : #accessing }
PjTArray >> first [
	<javascript: 'return this[0]'>
]

{ #category : #testing }
PjTArray >> ifEmpty: aBlock [
	self isEmpty ifTrue: [^aBlock value].
	^self
]

{ #category : #testing }
PjTArray >> includes: x [
	^ 0<(self indexOf: x)
]

{ #category : #accessing }
PjTArray >> indexOf: x [
	<javascript: 'return this.indexOf(x)+1'>
]

{ #category : #accessing }
PjTArray >> insert: anObject before: spot [
	<javascript: 'this.splice(spot-1, 0, anObject);return anObject'>
]

{ #category : #testing }
PjTArray >> isEmpty [
	^ self size = 0
]

{ #category : #accessing }
PjTArray >> last [
	<javascript: 'return this[this.length-1]'>
]

{ #category : #enumerating }
PjTArray >> notEmpty [
	<javascript: 'return this.length!=0'>
]

{ #category : #accessing }
PjTArray >> second [
	<javascript: 'return this[1]'>
]

{ #category : #enumerating }
PjTArray >> select: aBlock [
	<javascript: 'var result=[];for(var i=0,max=this.length;i<max;++i){if(true==aBlock(this[i]))result.push(this[i])}return result'>
]

{ #category : #enumerating }
PjTArray >> size [
	<javascript: 'return this.length'>
]

{ #category : #accessing }
PjTArray >> third [
	<javascript: 'return this[2]'>
]

{ #category : #enumerating }
PjTArray >> with: otherCollection do: aBlock [ 
	<javascript: 'for(var i=0,max=this.length;i<max;++i)aBlock(this[i],otherCollection[i]);return this'>
]

{ #category : #enumerating }
PjTArray >> withIndexDo: aBlock [ 
	<javascript: 'for(var i=0,max=this.length;i<max;++i)aBlock(this[i],i+1);return this'>
]
