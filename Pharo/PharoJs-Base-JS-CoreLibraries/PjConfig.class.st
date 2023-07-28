"
I make it easier to build JS configuration objects. Properties are created on the fly by simply using accessors. If you don't use the `PjConfig class >> #jsObject:` constructor, then you need to ""freeze"" the object to avoid creating further properties using the `becomeJsObject` message.

Example
```
PjConfig jsObject: [: config| 
	(config 
		name: 'C3P0';
		model: 'Protocol Droid';
		parts)	 << [: parts |
			parts head << [: head | 
				head 
					eyes: {
						PjConfig << [: leftEye | 
							leftEye 
								side: 'left'; 
								color: 'yellow'
						].
						PjConfig << [: rightEye | ""...""].
					};
					mouth: { ""..."" }
			].
			parts arms: { ""..."" }
	]
]
```

```js
{
	name: 'C3P0',
	model: 'Protocol Droid',
	parts: {
		head: {
			eyes: [ 
					{
					side: 'left',
					color: 'yellow'
					}, 
					{,,,}
				]
			mouth: {,,,}
		}
		arms: [,,,]
	}
}
```
The old basic way would be to use the PharoJS asJsObject as following:
``` 
{
	#name -> 'C3P0'.
	#model -> 'Protocol Droid'.
	#parts -> {
		#head -> {
			#eyes -> { 
					{
						#side -> 'left'.
						#color -> 'yellow'
					}. 
					{""...""}
				}.
			#mouth -> {""...""}
		}.
		#arms -> {""...""}	
	}
} asJsObject
```
"
Class {
	#name : #PjConfig,
	#superclass : #Object,
	#category : #'PharoJs-Base-JS-CoreLibraries-Kernel'
}

{ #category : #'instance creation' }
PjConfig class >> << aBlock [

	^ self new
		  << aBlock
]

{ #category : #'instance creation' }
PjConfig class >> jsObject: aBlock [

	^ (self << aBlock) becomeJsObject
]

{ #category : #'reflective operations' }
PjConfig >> << aBlock [

	aBlock value: self.
	^ self
]

{ #category : #'reflective operations' }
PjConfig >> becomeJsObject [

	Object adoptInstance: self.
	self valuesDo: [ :each |
		(each isKindOf: PjConfig) ifTrue: [ each asJsObject ] ]
]

{ #category : #'reflective operations' }
PjConfig >> doesNotUnderstand: aMessage [

	| propertyName value |
	aMessage arguments size > 1 ifTrue: [
		^ super doesNotUnderstand: aMessage ].
	aMessage arguments size = 1 ifTrue: [
	propertyName := (aMessage selector js_split: ':') js_at: 0.
		^ self js_at: propertyName put: aMessage arguments first ].
	propertyName := aMessage selector.
	value := self js_at: propertyName.
	^ value ifNil: [ self js_at: propertyName put: self class new ]
]

{ #category : #'doesNotUnderstand support' }
PjConfig >> pharoJsGetterDefaultValue [
	"Used by getters dynamically generated. See PjCore class >> #makeGetter: "

	<jsAlias: 'pharoJsGetterDefaultValue'>
	^ self class new
]
