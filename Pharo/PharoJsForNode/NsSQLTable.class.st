Class {
	#name : #NsSQLTable,
	#superclass : #Object,
	#instVars : [
		'db',
		'table',
		'with',
		'set',
		'names',
		'values',
		'where',
		'keys'
	],
	#pools : [
		'PjNodeGlobals'
	],
	#category : #'PharoJsForNode-SQL'
}

{ #category : #'instance creation' }
NsSQLTable class >> db: db table: tableName keys: keys [
	^ self new db: db; table: tableName; keys: keys;yourself
]

{ #category : #operations }
NsSQLTable >> all: cmd modifier: modifier with: aDictionary callback: aBlock [
	console log: cmd,' ',table,' ',modifier.
	console dir: aDictionary.
	db all: cmd,' ',table,' ',modifier with: aDictionary callBack: aBlock
]

{ #category : #operations }
NsSQLTable >> create: map [
	| fields |
	fields := OrderedCollection new.
	map keysAndValuesDo: [: k : value | fields add: k,' ',value].
	self run: 'CREATE TABLE' modifier: '(',(',' join: fields),')' with: nil callback: [  ]
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
	self run: 'CREATE UNIQUE INDEX ',aString,' ON' modifier: '(',(',' join: anArray),')' with: nil callback: [  ]
]

{ #category : #initialize }
NsSQLTable >> db: anObject [
	db := anObject
]

{ #category : #operations }
NsSQLTable >> exists: map callback: aBlock [
	self makeStrings: map.
	self get: 'SELECT EXISTS (SELECT 1 FROM' modifier: where,' LIMIT 1)' with: with callback: [: err : result |
		aBlock value: (result at: result keys first)=1
	]
]

{ #category : #operations }
NsSQLTable >> get: cmd modifier: modifier with: aDictionary callback: aBlock [
	console log: cmd,' ',table,' ',modifier.
	console dir: aDictionary.
	db get: cmd,' ',table,' ',modifier with: aDictionary callBack: aBlock
]

{ #category : #initialize }
NsSQLTable >> initialize [
	super initialize.
	keys := #()
]

{ #category : #operations }
NsSQLTable >> insert: map [
	self makeStrings: map.
	self run: 'INSERT OR IGNORE INTO' modifier: names,values with: with callback: [  ]
]

{ #category : #initialize }
NsSQLTable >> keys: anArray [
	keys := anArray
]

{ #category : #private }
NsSQLTable >> makeStrings: map [
	| comma and |
	and := comma := ''.
	with := Dictionary new.
	set := 'SET '.
	names := '('.
	where := 'WHERE '.
	values := ' VALUES ('.
	map keysAndValuesDo: [: k : value | | ref |
		ref := ':',k.
		with at: ref put: value value.
		value isSQLValue ifTrue: [
			ref := value block cull: table
		].
		set := set,comma,k,'=',ref.
		(keys includes: k) ifTrue: [
			where := where,and,k,'=',ref
		].
		names := names,comma,k.
		values := values,comma,ref.
		comma := ','.
		and := ' AND '
	].
	names := names,')'.
	values := values,')'
]

{ #category : #operations }
NsSQLTable >> run: cmd modifier: modifier with: aDictionary callback: aBlock [
	console log: cmd,' ',table,' ',modifier.
	"console dir: aDictionary."
	db run: cmd,' ',table,' ',modifier with: aDictionary callback: aBlock
]

{ #category : #operations }
NsSQLTable >> select: result with: map callback: aBlock [
	self makeStrings: map.
	self all: 'SELECT ',(',' join: result),' FROM' modifier: where with: with callback: aBlock
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
	self makeStrings: map.
	self run: 'UPDATE' modifier: set,' ',where with: with callback: [  ].
	self run: 'INSERT OR IGNORE INTO' modifier: names,values with: with callback: [  ]
]
