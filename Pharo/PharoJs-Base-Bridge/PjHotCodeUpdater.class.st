Class {
	#name : 'PjHotCodeUpdater',
	#superclass : 'Object',
	#instVars : [
		'factory',
		'bridge'
	],
	#pools : [
		'PjUniversalGlobals'
	],
	#category : 'PharoJs-Base-Bridge-Kernel',
	#package : 'PharoJs-Base-Bridge',
	#tag : 'Kernel'
}

{ #category : 'instance creation' }
PjHotCodeUpdater class >> bridge: aBridge [
	^self new
		bridge: aBridge;
		yourself	
]

{ #category : 'accessing' }
PjHotCodeUpdater >> bridge [

	^ bridge
]

{ #category : 'accessing' }
PjHotCodeUpdater >> bridge: aBridge [

	bridge := aBridge
]

{ #category : 'accessing' }
PjHotCodeUpdater >> globalThis [
	^self bridge jsGlobalAt: #globalThis
]

{ #category : 'initialization' }
PjHotCodeUpdater >> initialize [

	super initialize.
	factory := ClassFactoryForTestCase new.
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded
		do: [ :annoucement | self onMethodAdded: annoucement ]
		for: self;
		when: MethodModified
		do: [ :annoucement | self onMethodModified: annoucement ]
		for: self;
		when: MethodRemoved
		do: [ :annoucement | self onMethodRemoved: annoucement ]
		for: self;
		when: ClassRenamed
		do: [ :annoucement | self onClassRenamed: annoucement ]
		for: self;
		when: ClassModificationApplied
		do: [ : annoucement | self onClassModified: annoucement ]
		for: self
]

{ #category : 'removing' }
PjHotCodeUpdater >> jsSelectorFrom: selector [
	^String streamContents: [ : str | self transpiler writeJsSelector: selector onStream: str]
]

{ #category : 'updating' }
PjHotCodeUpdater >> loadClass: aClass [
	
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

	classExtension methodDict 
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
PjHotCodeUpdater >> onClassModified: annoucement [

	self 
		updateClassModified: annoucement classAffected

]

{ #category : 'annoucement handling' }
PjHotCodeUpdater >> onClassRenamed: annoucement [

	self 
		updateClass: annoucement classRenamed
		newName: annoucement newName 
		oldName: annoucement oldName
]

{ #category : 'annoucement handling' }
PjHotCodeUpdater >> onMethodAdded: annoucement [

	| newMethod |
	newMethod := annoucement methodAdded.
	self updateMethod: newMethod in: newMethod methodClass
]

{ #category : 'annoucement handling' }
PjHotCodeUpdater >> onMethodModified: annoucement [

	| newMethod |
	newMethod := annoucement newMethod.
	self updateMethod: newMethod in: newMethod methodClass
]

{ #category : 'annoucement handling' }
PjHotCodeUpdater >> onMethodRemoved: annoucement [

	| removedMethod |
	removedMethod := annoucement methodRemoved.
	self removeMethod: removedMethod from: removedMethod methodClass
]

{ #category : 'removing' }
PjHotCodeUpdater >> removeMethod: removedMethod from: aClass [

	| selector |
	(self shouldUpdateClass: aClass) ifFalse: [ ^self ].
	selector := removedMethod selector.
	aClass isMeta ifTrue: [
		^ self removeMethodAt: selector fromMetaclass: aClass ].
	self removeMethodAt: selector fromClass: aClass
]

{ #category : 'removing' }
PjHotCodeUpdater >> removeMethodAt: selector fromClass: aMetaclass [
	| jsClass jsSelector |
	jsClass := self bridge jsGlobalAt: aMetaclass instanceSide name.
	jsSelector := self jsSelectorFrom: selector. 
	jsClass prototype at: jsSelector put: nil
]

{ #category : 'removing' }
PjHotCodeUpdater >> removeMethodAt: selector fromMetaclass: aMetaclass [
	| jsClass jsSelector |
	jsClass := self bridge jsGlobalAt: aMetaclass instanceSide name.
	jsSelector := self jsSelectorFrom: selector. 
	jsClass at: jsSelector put: nil
]

{ #category : 'testing' }
PjHotCodeUpdater >> shouldUpdateClass: aClass [

	self bridge ifNil: [ ^false ].
	self bridge isConnected ifFalse: [ ^false ].
	^self transpiler isAlreadyConverted: aClass instanceSide 
]

{ #category : 'accessing' }
PjHotCodeUpdater >> transpiler [

	^ self bridge transpiler
]

{ #category : 'initialization' }
PjHotCodeUpdater >> unsubscribe [

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : 'updating' }
PjHotCodeUpdater >> updateClass: aClass newName: newName oldName: oldName [
	"Javascript class names are read-only.
	So, we need to make it writable first."

	| jsClass |
	(self shouldUpdateClass: aClass) ifFalse: [ ^ self ].
	jsClass := self bridge jsGlobalAt: oldName.
	self bridge evalBlock: [
		globalThis at: newName put: jsClass.
		jsClass forceInstVarNamed: #name put: newName ]
]

{ #category : 'updating' }
PjHotCodeUpdater >> updateClassModified: aClass [
	
	| jsClass jsOldSuperclass jsNewSuperclass currentSuperclass |
	aClass isMeta ifTrue: [ ^self ].
	(self shouldUpdateClass: aClass) ifFalse: [ ^self ].
	jsClass := self bridge jsGlobalAt: aClass name.
	currentSuperclass := aClass superclass. 
	jsOldSuperclass := jsClass superclass.
	jsOldSuperclass name == currentSuperclass name ifTrue: [ ^self ].
	self loadClass: currentSuperclass.
	jsNewSuperclass := self bridge jsGlobalAt: currentSuperclass name.
	jsClass superclass: jsNewSuperclass.
	jsOldSuperclass removeSubclass: jsClass.
	jsNewSuperclass addSubclass: jsClass
]

{ #category : 'updating' }
PjHotCodeUpdater >> updateMethod: aCompiledMethod in: aClass [

	(self shouldUpdateClass: aClass) ifFalse: [ ^self ].
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
		factory delete: extension 
	]
]
