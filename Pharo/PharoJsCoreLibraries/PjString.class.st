"
strings in Javascript world
"
Class {
	#name : #PjString,
	#superclass : #PjObject,
	#traits : 'PjTExtensionClass + PjTArray',
	#classTraits : 'PjTExtensionClass classTrait + PjTArray classTrait',
	#pools : [
		'PjDomGlobals'
	],
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #'instance creation' }
PjString class >> defaultSize [
	^10 
]

{ #category : #'pharoJs support' }
PjString class >> jsTranspilationImportMethods [
	<pharoJsSkip>
	^ self jsTranspilationImportMethodsArray,
	{
			String class -> #(
				stringHash:initialHash: fromByteArray:
			).
			String -> #(
				findTokens: 
			).
			Symbol -> #(
				cull: value: 
			).
			Character class -> #(
				cr escape lf linefeed space tab
			).
			Character -> #(
				isVowel isCharacter to:
			).
		}
]

{ #category : #'instance creation' }
PjString class >> new [
	^ ''
]

{ #category : #'instance creation' }
PjString class >> new: ignored [
	^ self new
]

{ #category : #'instance creation' }
PjString class >> streamContents: aBlock [
	| stream |
	stream := PjStringStream new.
	aBlock value: stream.
	^ stream contents
]

{ #category : #'instance creation' }
PjString class >> value: anInteger [
	^ String js_fromCharCode: anInteger
]

{ #category : #copying }
PjString >> , other [
	<javascript: 'return this+other'>
]

{ #category : #comparing }
PjString >> < other [
	<javascript: 'return this<other'>
]

{ #category : #comparing }
PjString >> <= other [
	<javascript: 'return this<=other'>
]

{ #category : #comparing }
PjString >> = other [
	<javascript: 'return this==other'>
]

{ #category : #comparing }
PjString >> > other [
	<javascript: 'return this>other'>
]

{ #category : #comparing }
PjString >> >= other [
	<javascript: 'return this>=other'>
]

{ #category : #accessing }
PjString >> allButFirst [
	^ self js_substring: 1
]

{ #category : #accessing }
PjString >> allButFirst: n [
	^ self js_substring: n
]

{ #category : #accessing }
PjString >> allButLast [
	^ self js_substring: 0 to: self size - 1
]

{ #category : #accessing }
PjString >> allButLast: n [
	^ self js_substring: 0 to: self size - n
]

{ #category : #converting }
PjString >> asCharacter [
	^ self js_charAt: 0
]

{ #category : #converting }
PjString >> asDate [
	<javascript: 'return new Date(this)'>
]

{ #category : #converting }
PjString >> asElementId [
	^ document getElementById: self
]

{ #category : #converting }
PjString >> asElementSelector [
	^ document querySelector: self
]

{ #category : #converting }
PjString >> asInteger [
	<javascript: 'return parseInt(this)'>
]

{ #category : #converting }
PjString >> asJsObject [
	"Ensure we get a primitive type string and not a String object"
	<javascript: 'return this.valueOf()'>
]

{ #category : #converting }
PjString >> asLowercase [
	^ self js_toLowerCase
]

{ #category : #converting }
PjString >> asNumber [
	<javascript: 'return parseFloat(this)'>
]

{ #category : #converting }
PjString >> asRegex [
	<javascript: 'return new RegExp(this)'>
]

{ #category : #converting }
PjString >> asString [
	<javascript: 'return ""+this'>
]

{ #category : #converting }
PjString >> asSymbol [
	<javascript: 'return ""+this'>
]

{ #category : #converting }
PjString >> asUppercase [
	^ self js_toUpperCase
]

{ #category : #accessing }
PjString >> asciiValue [
	^ self js_charCodeAt: 0
]

{ #category : #accessing }
PjString >> at: index [
	"JavaScript arrays first index is 0 "
	<javascript: 'return this[index - 1];'>
]

{ #category : #accessing }
PjString >> at: index put: anObject [
	<javascript: 'throw new Error("cannot mutate strings");'>
]

{ #category : #accessing }
PjString >> basicAt: aNumber [
	^ 	self js_charCodeAt: aNumber-1
]

{ #category : #comparing }
PjString >> beginsWith: prefix [
	^ (self js_substring: 0 to: prefix size)=prefix
]

{ #category : #converting }
PjString >> capitalized [
	self isEmpty ifTrue: [ ^self ].
	^ (self js_charAt:0) js_toUpperCase,(self js_substring: 1)
]

{ #category : #accessing }
PjString >> charCode [
	^ self basicAt: 1
]

{ #category : #accessing }
PjString >> codePoint [
	^ self js_charCodeAt: 0
]

{ #category : #enumerating }
PjString >> collect: aBlock [
	| arr |
	arr := self js_split: ''.
	1 to: self size do: [: idx |
		arr at: idx put: (aBlock value: (arr at: idx))
	].
	^ arr js_join: ''
]

{ #category : #comparing }
PjString >> copyFrom: start [
	^ self js_substring: start-1
]

{ #category : #comparing }
PjString >> copyFrom: start to: stop [
	^ self js_substring: start-1 to: stop
]

{ #category : #comparing }
PjString >> endsWith: suffix [
	^ (self js_substring: self size - suffix size)=suffix
]

{ #category : #accessing }
PjString >> first [
	^self at: 1
]

{ #category : #accessing }
PjString >> first: n [
	^ self js_substring: 0 to: n
]

{ #category : #comparing }
PjString >> hash [
	"#hash is implemented, because #= is implemented"
	"ar 4/10/2005: I had to change this to use ByteString hash as initial 
	hash in order to avoid having to rehash everything and yet compute
	the same hash for ByteString and WideString."
	^ self class stringHash: self initialHash: 0
]

{ #category : #testing }
PjString >> ifEmpty: aBlock [
	self isEmpty ifTrue: [^aBlock value].
	^self
]

{ #category : #testing }
PjString >> isEmpty [
	^self = ''
]

{ #category : #testing }
PjString >> isJSPrimitiveType [
	^ true
]

{ #category : #testing }
PjString >> isLetter [
	^self letterCharCodes includes: (self js_charCodeAt: 0)

]

{ #category : #testing }
PjString >> isString [
	^ true
]

{ #category : #splitjoin }
PjString >> join: anArray [
	^ anArray js_join: self
]

{ #category : #accessing }
PjString >> last [
	^self at: self size
]

{ #category : #accessing }
PjString >> lastIndexOf: x [
	<javascript: 'return this.lastIndexOf(x)+1'>
]

{ #category : #testing }
PjString >> letterCharCodes [
	^#(65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 170 181 186 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 248 249 250 251 252 253 254 255)
]

{ #category : #testing }
PjString >> notEmpty [
	^self ~= ''
]

{ #category : #proxy }
PjString >> proxyResponse [
	<javascript: 'return ""+this'>
]

{ #category : #writing }
PjString >> readStream [
	^ PjStringStream on: self
]

{ #category : #accessing }
PjString >> replaceFrom: start to: stop with: replacement startingAt: repStart [
	<javascript: '
	var repl=[],isString=typeof replacement=="string";
	for(var mine=stop-1,other=mine+repStart-start;
		mine>=start-1;
		--other,--mine
		)repl[other]=isString?replacement[other]:String.fromCharCode(replacement[other]);
		return this.substring(0,start-1)+repl.join("")+this.substr(stop)'>
]

{ #category : #accessing }
PjString >> size [
	^self js_at:#length
]

{ #category : #splitjoin }
PjString >> split: anArray [
	^ anArray js_split: self
]

{ #category : #converting }
PjString >> value [
	<javascript: 'return ""+this'>
]

{ #category : #writing }
PjString >> writeStream [
	^ PjStringStream new
]

{ #category : #comparing }
PjString >> ~= other [
	<javascript: 'return this!=other'>
]
