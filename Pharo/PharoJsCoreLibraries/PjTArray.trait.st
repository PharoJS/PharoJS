"
I implement operations for array-like things in Javascript
"
Trait {
	#name : #PjTArray,
	#traits : 'PjTCollection',
	#classTraits : 'PjTCollection classTrait',
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #enumerating }
PjTArray classSide >> collect_jsGenerator: transpiler [
	<pharoJsSkip> 
	^'var result=[];for(var i=0,max=this.length;i<max;++i)result.push(typeof aBlock=="string"?$asNil$(this[i]).', transpiler pharoJsSelectorPrefix, 'perform_(aBlock):aBlock(this[i]));return result'
]

{ #category : #enumerating }
PjTArray classSide >> do_jsGenerator: transpiler [
	<pharoJsSkip>
	^'for(var i=0,max=this.length;i<max;++i)if(typeof aBlock=="string")$asNil$(this[i]).', transpiler pharoJsSelectorPrefix, 'perform_(aBlock);else aBlock(this[i])'
]

{ #category : #enumerating }
PjTArray classSide >> do_separatedBy_jsGenerator: transpiler [
	<pharoJsSkip>
	^'for(var i=0,max=this.length;i<max;++i){if(i)separatorBlock();if(typeof elementBlock=="string")$asNil$(this[i]).', transpiler pharoJsSelectorPrefix, 'perform_(elementBlock);else elementBlock(this[i])}'
]

{ #category : #testing }
PjTArray classSide >> includes_jsGenerator: transpiler [
	<pharoJsSkip>
	^'if (x.', transpiler pharoJsSelectorPrefix, 'isJSPrimitiveType()) {
		if (this.includes(x)) return true;
		for(var i=this.length-1;i>=0;--i) if (x==this[i]) return true;
		return false}		
	for(var i=this.length-1;i>=0;--i) if (x.', transpiler pharoJsSelectorPrefix, '61_(this[i])) return true;
	return false'
]

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
	 	ArrayedCollection class -> #(with: with:with: with:with:with: with:with:with:with:).

	} 
]

{ #category : #enumerating }
PjTArray classSide >> select_jsGenerator: transpiler [
	<pharoJsSkip> 
	^'var result=[];for(var i=0,max=this.length;i<max;++i){if(true==(typeof aBlock=="string"?$asNil$(this[i]).', transpiler pharoJsSelectorPrefix, 'perform_(aBlock):aBlock(this[i])))result.push(this[i])}return result'
]

{ #category : #copying }
PjTArray >> , other [
	^ self class new addAll: self; addAll: other; yourself
]

{ #category : #enumerating }
PjTArray >> = anArray [
	self size = anArray size ifFalse: [ ^false ].
	self with: anArray do: [ : myElement : otherElement|
		myElement = otherElement ifFalse: [ ^false ]
	].
	^true
]

{ #category : #converting }
PjTArray >> asJsObject [
	| jsObject |
	(self notEmpty and: [(self first isKindOf: Association) not]) ifTrue: [ 
		^self
	].
	jsObject := Object new.
	self do: [ : association |
		jsObject at: association key put: association value asJsObject].
	^jsObject
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
	<jsGenerator: #collect_jsGenerator:>
]

{ #category : #enumerating }
PjTArray >> do: aBlock [
	<jsGenerator: #do_jsGenerator:>
]

{ #category : #enumerating }
PjTArray >> do: elementBlock separatedBy: separatorBlock [
	<jsGenerator: #do_separatedBy_jsGenerator:>

]

{ #category : #accessing }
PjTArray >> first [
	<javascript: 'return this[0]'>
]

{ #category : #accessing }
PjTArray >> first: n [
	<javascript: 'return this.slice(0,n)'>
]

{ #category : #testing }
PjTArray >> ifEmpty: aBlock [
	self isEmpty ifTrue: [^aBlock value].
	^self
]

{ #category : #testing }
PjTArray >> includes: x [
	<jsGenerator: #includes_jsGenerator:>
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

{ #category : #accessing }
PjTArray >> last: n [
	<javascript: 'return this.slice(this.length-n)'>
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
	<jsGenerator: #select_jsGenerator:>
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
