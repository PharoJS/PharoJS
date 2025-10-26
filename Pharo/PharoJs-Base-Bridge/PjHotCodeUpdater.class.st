Class {
	#name : 'PjHotCodeUpdater',
	#superclass : 'Object',
	#instVars : [
		'factory'
	],
	#category : 'PharoJs-Base-Bridge-Kernel',
	#package : 'PharoJs-Base-Bridge',
	#tag : 'Kernel'
}

{ #category : 'accessing' }
PjHotCodeUpdater >> bridge [

	^ PjBridge soleBridge
]

{ #category : 'initialization' }
PjHotCodeUpdater >> initialize [

	super initialize.
	factory := ClassFactoryForTestCase new.
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded
		do: [ :annoucement | self onMethodAdded: annoucement ]
		for: self
]

{ #category : 'updating' }
PjHotCodeUpdater >> isLoadedClass: aClass [

	^self bridge transpiler isAlreadyConverted: aClass instanceSide 
]

{ #category : 'updating' }
PjHotCodeUpdater >> loadClass: aClass [
	
	self bridge isConnected ifFalse: [ ^self].
	self bridge loadClass: aClass instanceSide.

]

{ #category : 'updating' }
PjHotCodeUpdater >> loadClassExtension: classExtension withClassMethod: newMethod [
	classExtension class methodDict 
		at: newMethod selector
		put: newMethod.
	self loadClass: classExtension
]

{ #category : 'updating' }
PjHotCodeUpdater >> loadClassExtension: classExtension withInstanceMethod: newMethod [

	classExtension compiledMethod 
		at: newMethod selector 
		put: newMethod.
	self loadClass: classExtension
]

{ #category : 'updating' }
PjHotCodeUpdater >> newClassExtensionFor: aBehavior [

	| actualClass  extension |
	actualClass := aBehavior instanceSide.
	extension := factory silentlyNewClass.
	extension class compile: 'javascriptName
			<pharoJsSkip>
	^ #' , actualClass name.
	^extension
]

{ #category : 'annoucement handling' }
PjHotCodeUpdater >> onMethodAdded: annoucement [

	| newMethod |
	newMethod := annoucement methodAdded.
	self updateMethod: newMethod in: newMethod methodClass
]

{ #category : 'initialization' }
PjHotCodeUpdater >> unsubscribe [

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : 'updating' }
PjHotCodeUpdater >> updateMethod: aCompiledMethod in: aClass [

	(self isLoadedClass: aClass) ifFalse: [ ^self ].
	aClass isMeta ifTrue: [
		^ self updateMethod: aCompiledMethod inMetaclass: aClass ].
	self updateMethod: aCompiledMethod inClass: aClass
]

{ #category : 'updating' }
PjHotCodeUpdater >> updateMethod: aCompiledMethod inClass: aMetaclass [

	self
		withNewClassExtensionFor: aMetaclass
		do: [ :classExtension |
			self loadClassExtension: classExtension withInstanceMethod: aCompiledMethod ]
]

{ #category : 'updating' }
PjHotCodeUpdater >> updateMethod: aCompiledMethod inMetaclass: aMetaclass [

	self
		withNewClassExtensionFor: aMetaclass
		do: [ :classExtension |
			self loadClassExtension: classExtension withClassMethod: aCompiledMethod ]
]

{ #category : 'updating' }
PjHotCodeUpdater >> withNewClassExtensionFor: aBehavior do: aBlock [

	| extension |
	[
		extension := self newClassExtensionFor: aBehavior.
		aBlock value: extension 
	] ensure: [ 
		factory cleanUp
	]
]
