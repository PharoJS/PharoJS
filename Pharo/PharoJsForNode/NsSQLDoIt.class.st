Class {
	#name : #NsSQLDoIt,
	#superclass : #Object,
	#instVars : [
		'table',
		'names',
		'values',
		'db',
		'with',
		'set',
		'where',
		'keys',
		'limit'
	],
	#pools : [
		'PjNodeGlobals'
	],
	#category : #'PharoJsForNode-SQL'
}

{ #category : #action }
NsSQLDoIt >> command: cmd modifier: modifier [
	self run: cmd,' ',table,' ',modifier with: nil callback: nil
]

{ #category : #action }
NsSQLDoIt >> command: cmd modifier: modifier withCallback: aBlock [
	self run: cmd,' ',table,' ',modifier with: nil callback: aBlock
]

{ #category : #accessing }
NsSQLDoIt >> db: anObject [
	db := anObject
]

{ #category : #'build items' }
NsSQLDoIt >> fieldsFromMap: map [
	| comma and |
	and := comma := ''.
	with := Dictionary new.
	set := 'SET '.
	names := '('.
	where := 'WHERE '.
	values := ' VALUES ('.
	map associationsDo: [:assoc | | ref key value |
		key := assoc key value.
		ref := ':', key.
		value := assoc value.
		with at: ref put: value value.
		value isSQLValue ifTrue: [
			ref := value block cull: table
		].
		(keys includes: key) ifTrue: [
			where := where,and,key,'=',ref.
			and := ' AND '
		].
		set := set,comma,key,'=',ref.
		names := names,comma,key.
		values := values,comma,ref.
		comma := ','
	].
	names := names,')'.
	values := values,')'
]

{ #category : #action }
NsSQLDoIt >> insertOrIgnoreWithCallback: aBlock [
	| cmd |
	cmd := 'INSERT OR IGNORE INTO ',table,' ',names,values.
	self run: cmd with: with callback: aBlock
]

{ #category : #accessing }
NsSQLDoIt >> keys: anObject [
	keys := anObject
]

{ #category : #accessing }
NsSQLDoIt >> limit: anObject [
	limit := anObject
]

{ #category : #private }
NsSQLDoIt >> run: cmd with: aDictionary callback: aBlock [
	aBlock ifNil: [
		aDictionary ifNil: [
			db run: cmd
		] ifNotNil: [
			db run: cmd with: aDictionary
		]
	] ifNotNil: [
		db run: cmd with: (aDictionary ifNil: #()) callback: aBlock]
]

{ #category : #action }
NsSQLDoIt >> select: resultFields withCallback: aBlock [
	| cmd |
	cmd :=  'SELECT ',(',' join: resultFields),' FROM ',table,' ',where.
	limit ifNotNil: [ cmd := cmd,' LIMIT ',limit asString ].
	db all: cmd with: with callback: aBlock
]

{ #category : #accessing }
NsSQLDoIt >> table: anObject [
	table := anObject
]

{ #category : #action }
NsSQLDoIt >> updateWithCallback: aBlock [
	| cmd |
	cmd :=  'UPDATE ',table,' ',set,' ',where.
	self run: cmd with: with callback: aBlock
]
