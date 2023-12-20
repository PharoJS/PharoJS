"
I implement operations for array-like things in Javascript
"
Trait {
	#name : #PjTArray,
	#traits : 'PjTCollection',
	#classTraits : 'PjTCollection classTrait',
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'instance creation' }
PjTArray classSide >> basicNew [
	"To support sending the initialize message even from plain JS using the new operator 
	PjFunction class >> basicNew sends an argument to the JS constructor. 
	This breaks array creation. Hence the redefinition."

	" More in `PjTranspiler>>#writeInitializeSupportFor: aClass`"

	<javascript: 'return new this()'>
	
]

{ #category : #enumerating }
PjTArray classSide >> collect_jsGenerator: transpiler [
	<pharoJsSkip> 
	^'var result=[];for(var i=0,max=this.length;i<max;++i)result.push(typeof aBlock=="string"?$asNil$(this[i]).', transpiler pharoJsSelectorPrefix, 'perform_(aBlock):aBlock(this[i]));return result'
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
	^ self jsTranspilationImportMethodsCollection , {
		  (Array
		   -> #( isArray shouldBePrintedAsLiteral shouldBePrintedAsLiteral:
			      printAsLiteralFormOn: isSelfEvaluating printAsSelfEvaluatingFormOn:
			      isLiteral isSelfEvaluating:)).
		  (ByteArray -> #( asString )).
		  (OrderedCollection -> #( join: addAllLast: )).
		  (Collection
		   ->
		   #( doWithIndex: printElementsOn: printNameOn: identityIncludes: )).
		  (SequenceableCollection
		   ->
			   #( withIndexDo: allButFirst allButFirst: allButLast allButLast:
			      #copyFrom:to: #copyReplaceFrom:to:with:
			      copyWith: copyWithFirst: copyWithoutIndex: #from:to:put:
			      grownBy: #replaceFrom:to:with: reverseDo: appendTo: putOn: )).
		  (ArrayedCollection class
		   -> #( with: #with:with: #with:with:with: #with:with:with:with: )) }
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
	self == anArray ifTrue: [ ^true ].
	(anArray isKindOf: Array) ifFalse: [^false].
	self size = anArray size ifFalse: [ ^false ].
	self with: anArray do: [ : myElement : otherElement|
		myElement = otherElement ifFalse: [ ^false ]
	].
	^true
]

{ #category : #converting }
PjTArray >> asArray [
	^ Array from: self
]

{ #category : #converting }
PjTArray >> asJsObject [
	| jsObject |
	self isEmpty ifTrue: [ ^ self ].
	(self first isKindOf: Association) ifFalse: [
		^ self collect: [: each | each asJsObject ]
	].
	jsObject := Object new.
	self do: [ : association |
		jsObject at: association key put: association value asJsObject].
	^jsObject
]

{ #category : #converting }
PjTArray >> asSortedCollection [
	^ SortedCollection new addAll: self;yourself
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

{ #category : #converting }
PjTArray >> becomeJsObject [

	self do: [ :each | each becomeJsObject ]
]

{ #category : #enumerating }
PjTArray >> collect: aBlock [
	<jsGenerator: #collect_jsGenerator:>
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
PjTArray >> eighth [
	<javascript: 'return this[7]'>
]

{ #category : #accessing }
PjTArray >> fifth [
	<javascript: 'return this[4]'>
]

{ #category : #accessing }
PjTArray >> first [
	<javascript: 'return this[0]'>
]

{ #category : #accessing }
PjTArray >> first: n [
	<javascript: 'return this.slice(0,n)'>
]

{ #category : #accessing }
PjTArray >> fourth [
	<javascript: 'return this[3]'>
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
PjTArray >> indexOf: x startingAt: n [
	<javascript: 'return this.indexOf(x,n-1)+1'>
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

{ #category : #accessing }
PjTArray >> ninth [
	<javascript: 'return this[8]'>
]

{ #category : #enumerating }
PjTArray >> notEmpty [
	<javascript: 'return this.length!=0'>
]

{ #category : #converting }
PjTArray >> reversed [
	^ self asArray reverse
]

{ #category : #accessing }
PjTArray >> second [
	<javascript: 'return this[1]'>
]

{ #category : #enumerating }
PjTArray >> select: aBlock [
	<jsGenerator: #select_jsGenerator:>
]

{ #category : #accessing }
PjTArray >> seventh [
	<javascript: 'return this[6]'>
]

{ #category : #accessing }
PjTArray >> sixth [
	<javascript: 'return this[5]'>
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
