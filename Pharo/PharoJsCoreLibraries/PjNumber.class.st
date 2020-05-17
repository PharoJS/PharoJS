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

{ #category : #arithmetics }
PjNumber class >> divide_jsGenerator: transpiler [
	<pharoJsSkip> 
	^'if(anObject==0) return ZeroDivide.', transpiler pharoJsSelectorPrefix, 'signal();return this / anObject;'
]

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
	| selectorsForChronology numberSelectors |
	selectorsForChronology := #(year years week weeks day days hour hours minute minutes second seconds milliSecond milliSeconds),
		(Number selectorsInProtocol: '*PharoExtra-Chronology').
	numberSelectors := selectorsForChronology, #(floorLog: negated reciprocal log: asInteger asNumber squared even odd fractionPart integerPart // strictlyPositive positive negative raisedToInteger: raisedTo: isNumber isZero quo: rem: ceiling floor).
	^ self jsTranspilationImportMethodsMagnitude,
			{Number -> numberSelectors.
			Number class -> #(one).
			Integer -> #(asCharacter isPowerOfTwo).
			SmallInteger -> #(highBit basicIdentityHash identityHash hashMultiply hash).
			Float -> #(isInfinite rounded asFloat).
			Float class
				->
					#(denormalized e emax emin epsilon fmax fmin fminDenormalized fminNormalized halfPi infinity maxExactInteger nan negativeInfinity negativeZero one pi precision radix threePi twoPi zero)}
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
	<jsGenerator: #divide_jsGenerator:>
]

{ #category : #arithmetics }
PjNumber >> // anObject [
	^ Math floor: self / anObject
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

{ #category : #converting }
PjNumber >> @ y [ 
	^Point x: self y: y
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
	<javascript: 'return +this'>
]

{ #category : #converting }
PjNumber >> asJsObject [
	"Ensure we get a primitive type number and not a Number object"
	<javascript: 'return this.valueOf()'>
]

{ #category : #converting }
PjNumber >> asString [
	<javascript: 'return this + ""'>
]

{ #category : #'bit manipulation' }
PjNumber >> bitAnd: arg [ 
	<javascript: 'return this&arg'>
]

{ #category : #'bit manipulation' }
PjNumber >> bitInvert [
	<javascript: 'return ~this'>
]

{ #category : #'bit manipulation' }
PjNumber >> bitOr: arg [ 
	<javascript: 'return this|arg'>
]

{ #category : #'bit manipulation' }
PjNumber >> bitShift: shiftCount [
	<javascript: 'if (shiftCount<0) return this>>(-shiftCount);return this<<shiftCount'>
]

{ #category : #'bit manipulation' }
PjNumber >> bitXor: arg [ 
	<javascript: 'return this^arg'>
]

{ #category : #converting }
PjNumber >> ch [
	<javascript: 'return this + "ch"'>
]

{ #category : #converting }
PjNumber >> cm [
	<javascript: 'return this + "cm"'>
]

{ #category : #'mathematical functions' }
PjNumber >> cos [
	<javascript: 'return Math.cos(this);'>
]

{ #category : #converting }
PjNumber >> degreesToRadians [
	^ self * RadiansPerDegree

]

{ #category : #converting }
PjNumber >> em [
	<javascript: 'return this + "em"'>
]

{ #category : #converting }
PjNumber >> ex [
	<javascript: 'return this + "ex"'>
]

{ #category : #'mathematical functions' }
PjNumber >> exp [
	<javascript: 'return Math.exp(this);'>
]

{ #category : #'bit manipulation' }
PjNumber >> highBitOfPositiveReceiver [
	| shifted bitNo |
	"Answer the index of the high order bit of the receiver, or zero if the 
	receiver is zero. Receiver has to be positive!"
	shifted := self.
	bitNo := 0.
	[shifted < 65536]
		whileFalse: 
			[shifted := shifted bitShift: -16.
			bitNo := bitNo + 16].
	shifted < 256
		ifFalse: 
			[shifted := shifted bitShift: -8.
			bitNo := bitNo + 8].
	shifted < 16
		ifFalse: 
			[shifted := shifted bitShift: -4.
			bitNo := bitNo + 4].
	shifted < 4
		ifFalse: 
			[shifted := shifted bitShift: -2.
			bitNo := bitNo + 2].
	shifted < 2
		ifFalse: 
			[shifted := shifted bitShift: -1.
			bitNo := bitNo +1].
	^ shifted+bitNo
]

{ #category : #converting }
PjNumber >> in [
	<javascript: 'return this + "in"'>
]

{ #category : #testing }
PjNumber >> isFloat [
	^ self isInteger not
]

{ #category : #testing }
PjNumber >> isInteger [
	<javascript: 'return (this|0)==this'>
]

{ #category : #testing }
PjNumber >> isJSPrimitiveType [
	^ true
]

{ #category : #testing }
PjNumber >> isNaN [
	<javascript: 'return isNaN(this)'>
]

{ #category : #'mathematical functions' }
PjNumber >> ln [
	<javascript: 'return Math.log(this);'>
]

{ #category : #'mathematical functions' }
PjNumber >> log [
	<javascript: 'return Math.log10(this);'>
]

{ #category : #'bit manipulation' }
PjNumber >> lowBit [
	" Answer the index of the low order one bit.
		2r00101000 lowBit       (Answers: 4)
		2r-00101000 lowBit      (Answers: 4)
	  First we skip bits in groups of 8, then by 1.
	  While not optimal, this is a good tradeoff; long
	  integer #lowBit always invokes us with bytes."
	| n result |
	n := self.
	n = 0 ifTrue: [ ^ 0 ].
	result := 1.
	[(n bitAnd: 16rFF) = 0]
		whileTrue: [
			result := result + 8.
			n := n bitShift: -8 ].
	[(n bitAnd: 1) = 0]
		whileTrue: [
			result := result + 1.
			n := n bitShift: -1 ].
	^ result
]

{ #category : #converting }
PjNumber >> mm [
	<javascript: 'return this + "mm"'>
]

{ #category : #converting }
PjNumber >> pc [
	<javascript: 'return this + "pc"'>
]

{ #category : #converting }
PjNumber >> percnt [
	<javascript: 'return this + "%"'>
]

{ #category : #proxy }
PjNumber >> proxyResponse [
	<javascript: 'return 0+this'>
]

{ #category : #converting }
PjNumber >> pt [
	<javascript: 'return this + "pt"'>
]

{ #category : #converting }
PjNumber >> px [
	<javascript: 'return this + "px"'>
]

{ #category : #converting }
PjNumber >> rem [
	<javascript: 'return this + "rem"'>
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
PjNumber >> to: end [
	| interval |
	interval := OrderedCollection new.
	self to: end by: 1 do: [ : each | interval add: each ].
	^interval
]

{ #category : #looping }
PjNumber >> to: end by: step [
	| interval |
	interval := OrderedCollection new.
	self to: end by: step do: [ : each | interval add: each ].
	^interval
]

{ #category : #looping }
PjNumber >> to: end by: step do: aBlock [
	<javascript: 'for(var i=this; step<0?i >= end:i <= end; i += step){aBlock(i);}'>
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

{ #category : #converting }
PjNumber >> vh [
	<javascript: 'return this + "vh"'>
]

{ #category : #converting }
PjNumber >> vmax [
	<javascript: 'return this + "vmax"'>
]

{ #category : #converting }
PjNumber >> vmin [
	<javascript: 'return this + "vmin"'>
]

{ #category : #converting }
PjNumber >> vw [
	<javascript: 'return this + "vw"'>
]

{ #category : #arithmetics }
PjNumber >> | anObject [
	<javascript: 'return this | anObject;'>
]

{ #category : #comparing }
PjNumber >> ~= other [
	<javascript: 'return this != other'>
]
