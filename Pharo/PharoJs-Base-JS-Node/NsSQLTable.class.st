Class {
	#name : #NsSQLTable,
	#superclass : #Object,
	#instVars : [
		'db',
		'table',
		'keys'
	],
	#pools : [
		'PjNodeGlobals'
	],
	#category : #'PharoJs-Base-JS-Node-SQL'
}

{ #category : #'instance creation' }
NsSQLTable class >> db: db table: tableName keys: keys [
	^ self new db: db; table: tableName; keys: keys;yourself
]

{ #category : #operations }
NsSQLTable >> create: map [
	| fields |
	fields := OrderedCollection new.
	map associationsDo: [: assoc | fields add: assoc key, ' ', assoc value].
	self makeDoIt
		command: 'CREATE TABLE' modifier: '(',(',' join: fields),')'
]

{ #category : #operations }
NsSQLTable >> createKey [
	self createKey: keys named: 'unique',table
]

{ #category : #operations }
NsSQLTable >> createKey: anArray [
	self createKey: anArray named: 'unique',table
]

{ #category : #operations }
NsSQLTable >> createKey: anArray named: aString [
	self makeDoIt
		command: 'CREATE UNIQUE INDEX ',aString,' ON' modifier: '(',(',' join: anArray),')'
]

{ #category : #initialize }
NsSQLTable >> db: anObject [
	db := anObject
]

{ #category : #operations }
NsSQLTable >> exists: map callback: aBlock [
	(self fieldsFromMap: map)
		limit: 1;
		select:  #(1) withCallback: [: err : result |
			err ifNotNil: [
				aBlock value: false
			] ifNil: [
				aBlock value: result isEmptyOrNil not
		]]
]

{ #category : #private }
NsSQLTable >> fieldsFromMap: map [
	^ self makeDoIt
		fieldsFromMap: map;
		yourself
]

{ #category : #initialize }
NsSQLTable >> initialize [
	super initialize.
	keys := #()
]

{ #category : #operations }
NsSQLTable >> insert: map [
	^ (self fieldsFromMap: map) insertOrIgnoreWithCallback: [  ]
]

{ #category : #initialize }
NsSQLTable >> keys: anArray [
	keys := anArray
]

{ #category : #private }
NsSQLTable >> makeDoIt [
	^ NsSQLDoIt new
		db: db;
		table: table;
		keys: keys;
		yourself
]

{ #category : #operations }
NsSQLTable >> select: result with: map callback: aBlock [
	(self fieldsFromMap: map)
		select: result withCallback: aBlock
]

{ #category : #operations }
NsSQLTable >> selectAll: aCollection callback: aBlock [
	^ self selectAll: aCollection callback: aBlock key: #key value: #value into: #()
]

{ #category : #operations }
NsSQLTable >> selectAll: aCollection callback: aBlock key: key value: value into: result [
	aCollection isEmpty ifTrue: [
		aBlock valueWithArguments: result
	] ifFalse: [
		self select: {value} with: { key -> aCollection first } callback: [ : err : resultRows |
			result addLast: (resultRows first at: value).
			self selectAll: aCollection allButFirst callback: aBlock key: key value: value into: result
	]]
]

{ #category : #initialize }
NsSQLTable >> table [
	^ table
]

{ #category : #initialize }
NsSQLTable >> table: aString [
	table := aString
]

{ #category : #operations }
NsSQLTable >> upsert: map [
	| doit |
	doit := self fieldsFromMap: map.
	doit updateWithCallback: [  ].
	doit insertOrIgnoreWithCallback: [  ]
]
