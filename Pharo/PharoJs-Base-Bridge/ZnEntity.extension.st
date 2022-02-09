Extension { #name : #ZnEntity }

{ #category : #'*PharoJs-Base-Bridge-Exporter' }
ZnEntity class >> css: css [

	^ self stringEntityClass css: css
]

{ #category : #'*PharoJs-Base-Bridge-Exporter' }
ZnEntity class >> favicon: favicon [

	^ ZnByteArrayEntity favicon: favicon
]

{ #category : #'*PharoJs-Base-Bridge-Exporter' }
ZnEntity class >> javascript: javascript [

	^ self stringEntityClass javascript: javascript
]
