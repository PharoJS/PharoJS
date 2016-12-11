"
I represent the Javascript Number type.  I am the implementation for Integer, Float, and Number, since Javascript Numbers are the only kind of numbers available.
"
Class {
	#name : #PjNumber,
	#superclass : #PjObject,
	#traits : 'PjTExtensionClass + PjTMagnitude',
	#classTraits : 'PjTExtensionClass classTrait + PjTMagnitude classTrait',
	#classVars : [
		'E',
		'Epsilon',
		'Halfpi',
		'Infinity',
		'Ln10',
		'Ln2',
		'MaxVal',
		'MaxValLn',
		'MinValLogBase2',
		'NaN',
		'NegativeInfinity',
		'NegativeZero',
		'Pi',
		'RadiansPerDegree',
		'Sqrt2',
		'ThreePi',
		'Twopi'
	],
	#pools : [
		'PjUniversalGlobals'
	],
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'class initialization' }
PjNumber class >> javascriptInitialize [
	Pi := Math instVarNamed: #PI.
	Halfpi := Pi / 2.0.
	Twopi := Pi * 2.0.
	ThreePi := Pi * 3.0.
	RadiansPerDegree := Pi / 180.0.

	Ln2 := Math instVarNamed: #LN2.
	Ln10 :=  Math instVarNamed: #LN10.
	Sqrt2 :=  Math instVarNamed: #SQRT2.
	E :=  Math instVarNamed: #E.

	Epsilon := 0.000000000001.  "Defines precision of mathematical functions"

	MaxVal := Number instVarNamed: #MAX_VALUE.
	MaxValLn := 709.782712893384.
	MinValLogBase2 := -1074.

	Infinity := Number instVarNamed: #POSITIVE_INFINITY.
	NegativeInfinity := Number instVarNamed: #NEGATIVE_INFINITY.
	NaN := Number instVarNamed: #NaN.
	NegativeZero := 1.0 / NegativeInfinity.

]

{ #category : #'pharoJs support' }
PjNumber class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ self jsTranspilationImportMethodsMagnitude,
		{Number -> #(
				negated reciprocal log: asInteger squared isNumber even odd isNaN fractionPart integerPart //
			).
		Integer -> #(
				asCharacter
			).
		Float -> #(
				rounded
			).
		}
]

{ #category : #arithmetics }
PjNumber >> % anObject [
	<javascript: 'return Math.sign(anObject)*(Math.abs(this) % anObject)'>
]

{ #category : #arithmetics }
PjNumber >> * anObject [
	<javascript: 'return this * anObject;'>
]

{ #category : #arithmetics }
PjNumber >> + anObject [
	<javascript: 'return this + anObject;'>
]

{ #category : #arithmetics }
PjNumber >> - anObject [
	<javascript: 'return this - anObject;'>
]

{ #category : #arithmetics }
PjNumber >> / anObject [
	<javascript: 'return this / anObject;'>
]

{ #category : #arithmetics }
PjNumber >> // anObject [
	<javascript: 'return Math.floor(this / anObject)'>
]

{ #category : #comparing }
PjNumber >> < other [
	<javascript: 'return this < other'>
]

{ #category : #comparing }
PjNumber >> = other [
	<javascript: 'return this == other'>
]

{ #category : #comparing }
PjNumber >> == other [
	<javascript: 'return this == other'>
]

{ #category : #arithmetics }
PjNumber >> \\ anObject [
	^ self % anObject
]

{ #category : #arithmetics }
PjNumber >> abs [
	<javascript: 'return Math.abs(this);'>
]

{ #category : #'mathematical functions' }
PjNumber >> arcCos [
	<javascript: 'return Math.acos(this);'>
]

{ #category : #'mathematical functions' }
PjNumber >> arcSin [
	<javascript: 'return Math.asin(this);'>
]

{ #category : #'mathematical functions' }
PjNumber >> arcTan [
	<javascript: 'return Math.atan(this);'>
]

{ #category : #'mathematical functions' }
PjNumber >> arcTan: denominator [
	<javascript: 'return Math.atan2(this,denominator);'>
]

{ #category : #converting }
PjNumber >> asFloat [
	<javascript: 'return +self'>
]

{ #category : #arithmetics }
PjNumber >> asString [
	<javascript: 'return this + "";'>
]

{ #category : #'mathematical functions' }
PjNumber >> cos [
	<javascript: 'return Math.cos(this);'>
]

{ #category : #converting }
PjNumber >> degreesToRadians [
	^ self * RadiansPerDegree

]

{ #category : #'mathematical functions' }
PjNumber >> exp [
	<javascript: 'return Math.exp(this);'>
]

{ #category : #'mathematical functions' }
PjNumber >> ln [
	<javascript: 'return Math.log(this);'>
]

{ #category : #'mathematical functions' }
PjNumber >> log [
	<javascript: 'return Math.log10(this);'>
]

{ #category : #proxy }
PjNumber >> proxyResponse [
	<javascript: 'return 0+this'>
]

{ #category : #'mathematical functions' }
PjNumber >> sign [
	<javascript: 'return Math.sign(this);'>
]

{ #category : #'mathematical functions' }
PjNumber >> sin [
	<javascript: 'return Math.sin(this);'>
]

{ #category : #'mathematical functions' }
PjNumber >> sqrt [
	<javascript: 'return Math.sqrt(this);'>
]

{ #category : #'mathematical functions' }
PjNumber >> tan [
	<javascript: 'return Math.tan(this);'>
]

{ #category : #looping }
PjNumber >> timesRepeat: aBlock [
	1 to: self do: aBlock
]

{ #category : #looping }
PjNumber >> to: end by: step do: aBlock [
	<javascript: 'for(var i=this; i <= end; i += step){aBlock(i);}'>
]

{ #category : #looping }
PjNumber >> to: end do: aBlock [
	self to: end by: 1 do: aBlock
]

{ #category : #converting }
PjNumber >> truncated [
	<javascript: 'if (this>=0)return Math.floor(this);return Math.ceil(this)'>
]

{ #category : #converting }
PjNumber >> value [
	<javascript: 'return 0+this'>
]

{ #category : #arithmetics }
PjNumber >> | anObject [
	<javascript: 'return this | anObject;'>
]

{ #category : #comparing }
PjNumber >> ~= other [
	<javascript: 'return this != other'>
]
