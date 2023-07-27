"
I make it easier to build JS configuration objects. Properties are created on the fly by simply using accessors. Example
```
PjJsConfig with: [: config| 
	config 
		name: 'C3P0';
		model: 'Protocol Droid';
		parts with: [: parts |
			parts head with: [: head | 
				head 
					eyes: {
						PjJsConfig with: [: leftEye | 
							leftEye side: 'left'; color: 'yellow'].
						PjJsConfig with: [: rightEye | ...].
					};
					mouth:  ...
			].
			parts arms: {...}
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
					{...}
				}
			#mouth -> {...}
		}
		#arms -> {...}
	}
}
```
"
Class {
	#name : #PjJsConfig,
	#superclass : #Object,
	#category : #'PharoJs-Base-App'
}

{ #category : #'instance creation' }
PjJsConfig class >> asJsObjectWith: aBlock [

	^ self new 
		with: aBlock;
		asJsObject 
]

{ #category : #'instance creation' }
PjJsConfig class >> with: aBlock [

	^ self new
		  with: aBlock
]

{ #category : #'reflective operations' }
PjJsConfig >> asJsObject [

	Object adoptInstance: self.
	self valuesDo: [ :each |
		(each isKindOf: PjJsConfig) ifTrue: [ each asJsObject ] ]
]

{ #category : #'reflective operations' }
PjJsConfig >> doesNotUnderstand: aMessage [

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
PjJsConfig >> pharoJsDynamicGetterDefaultValue [

	<jsAlias: 'pharoJsDynamicGetterDefaultValue'>
	^ self class new
]

{ #category : #'reflective operations' }
PjJsConfig >> with: aBlock [

	aBlock value: self.
	^self
]
